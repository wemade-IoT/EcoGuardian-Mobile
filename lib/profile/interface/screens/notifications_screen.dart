import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {

  static const String name = 'notifications_screen';

  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Notifications Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}