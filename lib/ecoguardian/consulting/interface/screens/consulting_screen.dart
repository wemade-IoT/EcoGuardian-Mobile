import 'package:flutter/material.dart';

class ConsultingScreen extends StatefulWidget {

  static const String name = 'consulting_screen';

  const ConsultingScreen({super.key});

  @override
  State<ConsultingScreen> createState() => _ConsultingScreenState();
}

class _ConsultingScreenState extends State<ConsultingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Consulting Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}