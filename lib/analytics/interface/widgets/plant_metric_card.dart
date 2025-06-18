import 'package:flutter/material.dart';

class PlantMetricCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String description;
  final Color? iconColor;

  const PlantMetricCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.description,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: iconColor?.withOpacity(0.15) ?? Colors.grey[200],
              radius: 26,
              child: Icon(icon, size: 32, color: iconColor ?? Colors.green),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              description,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

