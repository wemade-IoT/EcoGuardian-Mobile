import 'package:ecoguardian/analytics/interface/providers/plant_metrics_provider.dart';
import 'package:ecoguardian/analytics/domain/dto/plant_metrics.dto.dart';
import 'package:ecoguardian/shared/interface/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../monitoring/interface/providers/plant_provider.dart';
import '../../../planning/interface/providers/device_provider.dart';
import '../../../profile/interface/providers/notification_provider.dart';
import '../../../profile/interface/providers/profile_provider.dart';
import '../../../shared/infrastructure/helpers/date_helper.dart';
import '../widgets/consumption_line_chart.dart';
import '../widgets/plant_metric_card.dart';

class HomeScreen extends StatefulWidget {
  static const String name = 'home_screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedPlant = 0;

  Map<int,double> records = {
    1: 0.0,
    2: 0.0,
    3: 0.0,
    4: 0.0
  };
  List<dynamic> devices = [];
  String labels = "";
  List<dynamic> latestMetrics = [];

  List<FlSpot> waterData = [];
  List<FlSpot> humidityData = [];
  List<FlSpot> lightData = [];
  List<FlSpot> temperatureData = [];

  Future<void> assignDevices(int plantId, BuildContext context) async {
    devices = [];
    final deviceProvider = Provider.of<DeviceProvider>(context, listen: false);
   try{
     final data = await deviceProvider.getDevicesByPlantId(plantId);
     devices.add(data);
   } catch (e){
     throw Exception("No devices available");
   }
  }

  Future<void> getLatestMetrics(BuildContext context) async {
        final metricProvider = Provider.of<PlantMetricsProvider>(context, listen: false);
        final deviceList = devices.last;
        humidityData = [];
        lightData = [];
        temperatureData = [];
        waterData = [];
        labels = "";
        try {
          MetricRegistryDto metricRecords = await metricProvider.fetchLatestMetrics(deviceList.last.id);
          if (metricRecords.metrics != null && metricRecords.metrics!.isNotEmpty) {
            labels = normalizeDate(metricRecords.createdAt!);
            for (var metric in metricRecords.metrics!) {
              if (metric.metricTypesId == 1) {
                  humidityData.add(FlSpot(0, metric.metricValue!));
              }
              if (metric.metricTypesId == 2) {
                  lightData.add(FlSpot(10,  metric.metricValue!));
              }
              if (metric.metricTypesId == 3) {
                 temperatureData.add(FlSpot(2, metric.metricValue!));
              }
              if (metric.metricTypesId == 4) {
                  waterData.add(FlSpot(4, metric.metricValue!));
              }
            }
          } else {
            throw Exception('No metrics available for device ${deviceList.last.id}');
          }
        } catch (e) {
          throw Exception("An error has ocurred whilwe trying to fecth latest metrics by device id ${deviceList.last.id}: $e");
        }
  }


  Future<void> matchMetricsByDevice(Map<int, double> records, BuildContext context) async {
      final metricProvider = Provider.of<PlantMetricsProvider>(context, listen: false);
      Map<int, double> metricSums = {};
      Map<int, int> metricCounts = {};
      records.clear();
      for (var deviceList in devices) {
        for (var device in deviceList) {
          try {
            List<MetricRegistryDto> metricRecords = await metricProvider.fetchMetrics(device.id);

            for (var record in metricRecords) {
              for (var metric in record.metrics!) {
                int metricTypeId = metric.metricTypesId!;
                double metricValue = metric.metricValue?.toDouble() ?? 0;
                metricSums[metricTypeId] = (metricSums[metricTypeId] ?? 0) + metricValue;
                metricCounts[metricTypeId] = (metricCounts[metricTypeId] ?? 0) + 1;
              }
            }
          } catch (e) {
            throw Exception("An error has ocurred while trying to fecth metrics by device ${device.id}: $e");
          }
        }
      }
      for (var metricTypeId in metricSums.keys) {
        if (metricCounts[metricTypeId]! > 0) {
          records[metricTypeId] = metricSums[metricTypeId]! / metricCounts[metricTypeId]!;
        }
      }
  }

  final Map<int, Map<String, dynamic>> metricConfig = {
    1: {
      'icon': Icons.water_drop,
      'title': 'Water Consumption',
      'unit': 'L',
      'description': 'Your hourly water consumption',
      'iconColor': Colors.blue,
    },
    2: {
      'icon': Icons.water_damage_outlined,
      'title': 'Humidity Level',
      'unit': '%',
      'description': 'Your hourly humidity consumption',
      'iconColor': Colors.teal,
    },
    3: {
      'icon': Icons.wb_sunny_outlined,
      'title': 'Light Level',
      'unit': 'lx',
      'description': 'Your hourly light consumption',
      'iconColor': Colors.amber,
    },
    4: {
      'icon': Icons.ac_unit,
      'title': 'Temperature Level',
      'unit': 'Cº',
      'description': 'Your hourly temperature consumption',
      'iconColor': Colors.amber,
    },
  };

  List<Widget> buildMetricCards(Map<int, double> records) {
    List<Widget> cards = [];

    for (var entry in records.entries) {
      final metricId = entry.key;
      final value = entry.value;
      final config = metricConfig[metricId];
      if (config != null) {
        cards.add(
          PlantMetricCard(
            icon: config['icon'],
            title: config['title'],
            value: '${value.toStringAsFixed(1)} ${config['unit']}',
            description: config['description'],
            iconColor: config['iconColor'],
          ),
        );
        if (entry != records.entries.last) {
          cards.add(const SizedBox(height: 16));
        }
      }
    }

    return cards;
  }


  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await Provider.of<PlantProvider>(context, listen: false).getPlantsByUserId();
    });
    Future.microtask(() => Provider.of<NotificationProvider>(context, listen: false).getNotificationsByUserId());
    Future.microtask(() => Provider.of<ProfileProvider>(context, listen: false).getProfileByEmail());
  }

  @override
  Widget build(BuildContext context) {
    final plantProvider = context.watch<PlantProvider>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 32.0, bottom: 100.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Check your latest record and average consumption',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              CustomDropdown(
                  initialValue: selectedPlant,
                  options: plantProvider.plants,
                onChanged: (value) async{
                    setState(() {
                      selectedPlant = value!;
                    });
                     try{
                       await assignDevices(selectedPlant, context);
                     } catch (e){
                       throw Exception("No devices available");
                     }
                    if (devices.isNotEmpty) {
                      setState(() {

                      });
                      await Future.wait([
                        matchMetricsByDevice(records, context),
                        getLatestMetrics(context),
                      ]);
                      setState(() {

                      });
                    } else {
                      throw Exception("No se encontraron dispositivos.");
                    }
                },
              ),
              const SizedBox(height: 20),
              ConsumptionLineChart(
                waterData: waterData,
                label: labels,
                temperatureData: temperatureData,
                lightData: lightData,
                humidityData: humidityData,
              ),
              const SizedBox(height: 24),
              Consumer<PlantMetricsProvider>(
                builder: (context, provider, _) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (waterData.isNotEmpty  || lightData.isNotEmpty  || temperatureData.isNotEmpty || humidityData.isNotEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children:  buildMetricCards(records)
                    );
                  }
                  return const Center(
                    child: Text(
                        "No metrics available!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
