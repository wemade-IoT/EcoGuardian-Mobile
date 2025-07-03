import 'package:ecoguardian/profile/interface/providers/notification_provider.dart';
import 'package:ecoguardian/profile/interface/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:ecoguardian/analytics/interface/widgets/plant_metric_card.dart';
import 'package:ecoguardian/analytics/interface/widgets/consumption_line_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:ecoguardian/analytics/interface/providers/plant_metrics_provider.dart';
import 'package:ecoguardian/analytics/domain/dto/plant_metrics.dto.dart';

// Dude aqui, deberia estar el AnalyticsScreen, a decision del bc lider
class HomeScreen extends StatefulWidget {

  static const String name = 'home_screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<PlantMetricsProvider>(context, listen: false).fetchMetrics());
    Future.microtask(() => Provider.of<NotificationProvider>(context, listen: false).getNotificationsByUserId());
    Future.microtask(() => Provider.of<ProfileProvider>(context, listen: false).getProfileByEmail());
  }

  @override
  Widget build(BuildContext context) {
    // Datos de ejemplo para el gráfico
    final List<FlSpot> waterData = [
      FlSpot(0, 100),
      FlSpot(1, 120),
      FlSpot(2, 110),
      FlSpot(3, 130),
      FlSpot(4, 125),
    ];
    final List<FlSpot> energyData = [
      FlSpot(0, 80),
      FlSpot(1, 90),
      FlSpot(2, 85),
      FlSpot(3, 95),
      FlSpot(4, 100),
    ];
    final List<String> labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];

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
                  'Water and Energy Consumption',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              ConsumptionLineChart(
                waterData: waterData,
                energyData: energyData,
                labels: labels,
              ),
              const SizedBox(height: 24),
              Consumer<PlantMetricsProvider>(
                builder: (context, provider, _) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (provider.error != null) {
                    return Center(child: Text('Error loading metrics: \n${provider.error}'));
                  } else if (provider.waterMetric != null && provider.humidityMetric != null && provider.lightMetric != null) {
                    final water = provider.waterMetric!;
                    final humidity = provider.humidityMetric!;
                    final light = provider.lightMetric!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        PlantMetricCard(
                          icon: Icons.water_drop,
                          title: 'Water Consumption',
                          value: '${water.value} L',
                          description: water.description,
                          iconColor: Colors.blue,
                        ),
                        const SizedBox(height: 16),
                        PlantMetricCard(
                          icon: Icons.water_damage_outlined,
                          title: 'Humidity Level',
                          value: '${humidity.value}%',
                          description: humidity.description,
                          iconColor: Colors.teal,
                        ),
                        const SizedBox(height: 16),
                        PlantMetricCard(
                          icon: Icons.wb_sunny_outlined,
                          title: 'Light Level',
                          value: '${light.value} lx',
                          description: light.description,
                          iconColor: Colors.amber,
                        ),
                      ],
                    );
                  }
                  return const SizedBox();
                },
              ),
              // ...puedes agregar más widgets aquí...
            ],
          ),
        ),
      ),
    );
  }
}