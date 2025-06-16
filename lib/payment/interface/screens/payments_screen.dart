import 'package:flutter/material.dart';

class PaymentsScreen extends StatefulWidget {

  static const String name = 'payments_screen';

  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Payments Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}