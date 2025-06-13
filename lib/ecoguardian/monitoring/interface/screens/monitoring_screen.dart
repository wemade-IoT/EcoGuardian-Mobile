import 'package:flutter/material.dart';

class MonitoringScreen extends StatefulWidget {

  static const String name = 'monitoring_screen';

  const MonitoringScreen({super.key});

  @override
  State<MonitoringScreen> createState() => _MonitoringScreenState();
}

class _MonitoringScreenState extends State<MonitoringScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Monitoring Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}