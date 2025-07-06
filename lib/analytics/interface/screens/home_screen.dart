import 'package:ecoguardian/analytics/interface/providers/plant_metrics_provider.dart';
import 'package:ecoguardian/analytics/domain/dto/plant_metrics.dto.dart';
import 'package:ecoguardian/analytics/interface/widgets/consumption_line_chart.dart';
import 'package:ecoguardian/config/theme/app_theme.dart';
import 'package:ecoguardian/public/interface/widgets/custom_elevated_button.dart';
import 'package:ecoguardian/shared/interface/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../monitoring/interface/providers/plant_provider.dart';
import '../../../planning/interface/providers/device_provider.dart';
import '../../../profile/interface/providers/notification_provider.dart';
import '../../../profile/interface/providers/profile_provider.dart';
import '../../../shared/infrastructure/helpers/date_helper.dart';
import '../widgets/plant_metric_card.dart';

class HomeScreen extends StatefulWidget {
  static const String name = 'home_screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedPlant = 0;
  int indexPeriodSelected = 0;

  Map<int,double> records = {
    1: 0.0,
    2: 0.0,
    3: 0.0,
    4: 0.0
  };

  final List<String> periods= [
    "hourly",
    "daily",
    "weekly",
    "monthly",
    "yearly"
  ];
  List<dynamic> devices = [];
  List<String> labels = [];
  List<dynamic> latestMetrics = [];

  List<FlSpot> waterData = [];
  List<FlSpot> humidityData = [];
  List<FlSpot> lightData = [];
  List<FlSpot> temperatureData = [];

  Future<void> assignDevices(int plantId, BuildContext context) async {
    devices = [];
   try{
     final deviceProvider = Provider.of<DeviceProvider>(context, listen: false);
     final data = await deviceProvider.getDevicesByPlantId(plantId);
     devices.add(data);
   } catch (e){
     throw Exception("No devices available");
   }
  }


  Future<void> getLatestMetrics(BuildContext context, String period) async {
    final metricProvider = Provider.of<PlantMetricsProvider>(context, listen: false);
    final deviceList = devices.last;
    humidityData = [];
    lightData = [];
    temperatureData = [];
    waterData = [];
    labels = [];
    try {
      for (var device in deviceList){
        List<MetricRegistryDto> metricRecords = await metricProvider.fetchMetrics(device.id,period);
        for (var metricRecord in metricRecords){
          if (metricRecord.metrics != null && metricRecord.metrics!.isNotEmpty) {
            labels.add(normalizeDate(metricRecord.createdAt!));
            for (var metric in metricRecord.metrics!) {
              if (metric.metricTypesId == 1) {
                humidityData.add(FlSpot(0,0));
                humidityData.add(FlSpot(0, metric.metricValue!));
              }
              if (metric.metricTypesId == 2) {
               lightData.add(FlSpot(0,0));
                lightData.add(FlSpot(10,  metric.metricValue!));
              }
              if (metric.metricTypesId == 3) {
                temperatureData.add(FlSpot(0,0));
                temperatureData.add(FlSpot(2, metric.metricValue!));
              }
              if (metric.metricTypesId == 4) {
                waterData.add(FlSpot(0,0));
                waterData.add(FlSpot(4, metric.metricValue!));
              }
            }
          } else {
            throw Exception('No metrics available for device ${deviceList.last.id}');
          }
        }
      }
    } catch (e) {
      throw Exception("An error has ocurred whilwe trying to fecth latest metrics by device id ${deviceList.last.id}: $e");
    }
  }



  Future<void> matchMetricsByDevice(Map<int, double> records, BuildContext context) async {
      final metricProvider = Provider.of<PlantMetricsProvider>(context, listen: false);
      final device = devices.last;
      records.clear();
      for (var item in device){
        try {
          MetricRegistryDto metricRecords = await metricProvider.fetchLatestMetrics(item.id);
          for (var metric in metricRecords.metrics!) {
            int metricTypeId = metric.metricTypesId!;
            double metricValue = metric.metricValue?.toDouble() ?? 0;
            records[metricTypeId] = metricValue;
          }
        } catch (e) {
          throw Exception("An error has ocurred while trying to fecth metrics by device ${item.id}: $e");
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

    return cards ;
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
                  'Check your latest data',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
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
                        getLatestMetrics(context, "hourly")
                      ]);
                      setState(() {

                      });
                    } else {
                      throw Exception("No se encontraron dispositivos.");
                    }
                },
              ),
              const SizedBox(height: 24),
              Consumer<PlantMetricsProvider>(
                builder: (context, provider, _) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (records.isNotEmpty && devices.isNotEmpty) {
                    return Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children:  buildMetricCards(records)
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'Do you want to see more information?',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          )
                        ),
                        CustomElevatedButton(
                            onPressed: (){},
                            background: CustomColors.primary,
                            foreground: CustomColors.white,
                            label: "Visit our WebPage"
                        )
                      ],
                    );
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 15,
                    children: [
                      const  Text(
                            "No analytics data available.",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      const Text(
                          "If you have already registered a plant and you can read this message",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      const Text(
                        "Contact our support team",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.red
                        ),
                        textAlign: TextAlign.center,
                      )

                    ],
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
