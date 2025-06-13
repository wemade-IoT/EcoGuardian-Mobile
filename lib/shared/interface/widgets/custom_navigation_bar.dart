import 'package:ecoguardian/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final Function(int) onIndexSelected;
  final int index;

  const CustomNavigationBar({
    super.key,
    required this.onIndexSelected,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(bottom: 24),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 237, 237, 237),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Row(
          spacing: 40,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildNavIcon(Icons.home_rounded, 0, onIndexSelected, index),
            _buildNavIcon(Icons.monitor, 1, onIndexSelected, index), // Planta
            _buildNavIcon(Icons.question_answer_outlined, 2, onIndexSelected, index), // Pregunta
            _buildNavIcon(Icons.attach_money, 3, onIndexSelected, index), // Pago
            _buildNavIcon(Icons.person_outline_rounded, 4, onIndexSelected, index),
          ],
        ),
      ),
    );
  }
}

Widget _buildNavIcon(
  IconData icon,
  int itemIndex,
  Function(int) onIndexSelected,
  int currentIndex,
) {
  final isSelected = currentIndex == itemIndex;

  return GestureDetector(
    onTap: () => onIndexSelected(itemIndex),
    child: Container(
      width: 48,
      height: 48,
      decoration: isSelected
          ? BoxDecoration(
              color: CustomColors.checkoutGreen,
              shape: BoxShape.circle,
            )
          : null,
      child: Icon(
        icon,
        color: isSelected ? Colors.white : CustomColors.grey,
        size: 28,
      ),
    ),
  );
}