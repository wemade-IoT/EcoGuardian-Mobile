import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {

  static const String name = 'register_screen';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Register Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}