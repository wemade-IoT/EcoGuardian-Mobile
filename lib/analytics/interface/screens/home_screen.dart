import 'package:flutter/material.dart';
import 'package:ecoguardian/analytics/interface/widgets/plant_metric_card.dart';
import 'package:ecoguardian/analytics/interface/widgets/consumption_line_chart.dart';
import 'package:fl_chart/fl_chart.dart';

// Dude aqui, deberia estar el AnalyticsScreen, a decision del bc lider
class HomeScreen extends StatefulWidget {

  static const String name = 'home_screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    final List<String> labels = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie'];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 32.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ConsumptionLineChart(
                waterData: waterData,
                energyData: energyData,
                labels: labels,
              ),
              const SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  PlantMetricCard(
                    icon: Icons.water_drop,
                    title: 'Consumo de Agua',
                    value: '120 L',
                    description: 'Consumo de agua en esta planta.',
                    iconColor: Colors.blue,
                  ),
                  SizedBox(height: 16),
                  PlantMetricCard(
                    icon: Icons.water_damage_outlined,
                    title: 'Nivel de Humedad',
                    value: '65%',
                    description: 'Humedad del suelo',
                    iconColor: Colors.teal,
                  ),
                  SizedBox(height: 16),
                  PlantMetricCard(
                    icon: Icons.wb_sunny_outlined,
                    title: 'Nivel de Luz',
                    value: '800 lx',
                    description: 'Intensidad lumínica',
                    iconColor: Colors.amber,
                  ),
                ],
              ),
              // ...puedes agregar más widgets aquí...
            ],
          ),
        ),
      ),
    );
  }
}