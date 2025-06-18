import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color background;
  final Color foreground;
  final String label;
  const CustomElevatedButton({super.key, required this.onPressed, required this.background, required this.foreground, required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: background,
          foregroundColor: foreground,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          )
      ),
      child: Text(
          label,
        style: TextStyle(
          fontSize: 25
        ),
      ),
    );
  }
}
