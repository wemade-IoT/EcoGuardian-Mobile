import 'package:ecoguardian/analytics/interface/providers/plant_metrics_provider.dart';
import 'package:ecoguardian/analytics/domain/dto/plant_metrics.dto.dart';
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
  final averageRecords = {
    1: 0,
    2: 0,
    3: 0,
    4: 0
  };

  List<dynamic> devices = [];
String labels = "";
  List<dynamic> latestMetrics = [];

  List<FlSpot> waterData = [];
  List<FlSpot> humidityData = [];
  List<FlSpot> lightData = [];
  List<FlSpot> temperatureData = [];

  Future<void> assignDevices(List<dynamic> plantIds, BuildContext context) async {
    final deviceProvider = Provider.of<DeviceProvider>(context, listen: false);
    for (int i = 0; i < plantIds.length; i++) {
      final data = await deviceProvider.getDevicesByPlantId(plantIds[i]);
      devices.add(data);
    }
  }

  Future<void> getLatestMetrics(BuildContext context) async {
    final metricProvider = Provider.of<PlantMetricsProvider>(context, listen: false);

    for (var deviceList in devices) {
      for (var device in deviceList) {
        try {
          MetricRegistryDto metricRecords = await metricProvider.fetchLatestMetrics(device.id);
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
            throw Exception('No metrics available for device ${device.id}');
          }
        } catch (e) {
          throw Exception("Error al obtener las métricas para el dispositivo ${device.id}: $e");
        }
      }
    }
  }

  Future<void> matchMetricsByDevice(Map<int, int> records, BuildContext context) async {
    final metricProvider = Provider.of<PlantMetricsProvider>(context, listen: false);

    for (var deviceList in devices) {
      for (var device in deviceList) {
        try {
          List<MetricRegistryDto> metricRecords = await metricProvider.fetchMetrics(device.id);
          for (var record in metricRecords) {
            for (var metric in record.metrics!) {
              if (records.containsKey(metric.metricTypesId)) {
                int currentValue = records[metric.metricTypesId] ?? 0;
                int metricValue = metric.metricValue?.toInt() ?? 0;
                records[metric.metricTypesId!] = currentValue + metricValue;
              }
            }
          }
        } catch (e) {
          throw Exception("Error al obtener las métricas para el dispositivo ${device.id}: $e");
        }
      }
    }
  }

  Future<void> _initialize() async {
    final plantProvider = context.read<PlantProvider>();
    final List<dynamic> plantIds = plantProvider.plants.map((plant) => plant.id).toList();
    await assignDevices(plantIds, context);
    if (devices.isNotEmpty) {
      await matchMetricsByDevice(averageRecords, context);
      await getLatestMetrics(context);
    } else {
      throw Exception("No se encontraron dispositivos.");
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await Provider.of<PlantProvider>(context, listen: false).getPlantsByUserId();
      await _initialize();
      setState(() {});
    });
    Future.microtask(() => Provider.of<NotificationProvider>(context, listen: false).getNotificationsByUserId());
    Future.microtask(() => Provider.of<ProfileProvider>(context, listen: false).getProfileByEmail());
  }

  @override
  Widget build(BuildContext context) {
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
                  'Check your latest record and total consumptions',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
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
                  } else if (waterData.isNotEmpty || lightData.isNotEmpty || temperatureData.isNotEmpty || humidityData.isNotEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        PlantMetricCard(
                          icon: Icons.water_drop,
                          title: 'Water Consumption',
                          value: '${averageRecords[1]} L',
                          description: "Your hourly water consumption",
                          iconColor: Colors.blue,
                        ),
                        const SizedBox(height: 16),
                        PlantMetricCard(
                          icon: Icons.water_damage_outlined,
                          title: 'Humidity Level',
                          value: '${averageRecords[2]}%',
                          description: "Your hourly humidity consumption",
                          iconColor: Colors.teal,
                        ),
                        const SizedBox(height: 16),
                        PlantMetricCard(
                          icon: Icons.wb_sunny_outlined,
                          title: 'Light Level',
                          value: '${averageRecords[3]} lx',
                          description: "Your hourly light consumption",
                          iconColor: Colors.amber,
                        ),
                        const SizedBox(height: 16),
                        PlantMetricCard(
                          icon: Icons.ac_unit,
                          title: 'Temperature Level',
                          value: '${averageRecords[4]} Cº',
                          description: "Your hourly temperature consumption",
                          iconColor: Colors.amber,
                        ),
                      ],
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
