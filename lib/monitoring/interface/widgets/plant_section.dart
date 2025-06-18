import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlantSection extends StatelessWidget {
  final String label;
  final String value;
  const PlantSection({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
            label,
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.black
          ),
        ),
        Text(
            value,
          style: TextStyle(
              fontSize: 13.0,
              color: Colors.black
          ),
        )
      ],
    );
  }
}
