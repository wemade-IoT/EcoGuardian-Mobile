import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ConsumptionLineChart extends StatelessWidget {
  final List<FlSpot> waterData;
  final List<FlSpot> temperatureData;
  final List<FlSpot> lightData;
  final List<FlSpot> humidityData;
  final String label;

  const ConsumptionLineChart({
    super.key,
    required this.waterData,
    required this.temperatureData,
    required this.label,
    required this.lightData,
    required this.humidityData,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.6,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: true),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true, reservedSize: 40),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        label,
                        style: const TextStyle(fontSize: 12),
                      ),
                    );
                  },
                  interval: 1,
                  reservedSize: 32,
                ),
              ),
              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            borderData: FlBorderData(show: true),
            lineBarsData: [
              LineChartBarData(
                spots: waterData,
                isCurved: true,
                color: Colors.blue,
                barWidth: 3,
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(show: false),
              ),
              LineChartBarData(
                spots: temperatureData,
                isCurved: true,
                color: Colors.green,
                barWidth: 3,
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(show: false),
              ),
              LineChartBarData(
                spots: lightData,
                isCurved: true,
                color: Colors.yellow,
                barWidth: 3,
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(show: false),
              ),
              LineChartBarData(
                spots: humidityData,
                isCurved: true,
                color: Colors.orange,
                barWidth: 3,
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(show: false),
              ),
            ],
            minY: 0,
          ),
        ),
      ),
    );
  }
}