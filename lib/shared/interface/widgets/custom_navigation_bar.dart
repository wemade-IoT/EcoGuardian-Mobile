import 'package:ecoguardian/config/theme/app_theme.dart';
import 'package:ecoguardian/iam/interface/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomNavigationBar extends StatefulWidget {
  final Function(int) onIndexSelected;
  final int index;

  const CustomNavigationBar({
    super.key,
    required this.onIndexSelected,
    required this.index,
  });

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  bool isSpecialist = false;
  @override
  void initState(){
    super.initState();
    final authProvider = context.read<AuthProvider>();
    ()async{
      isSpecialist = await authProvider.isSpecialist();
      setState(() {
      });
    }();
  }
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 237, 237, 237),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Row(
          spacing: 20,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             !isSpecialist ? _buildNavIcon(Icons.home_rounded, 0, widget.onIndexSelected, widget.index) : Container(),
            !isSpecialist ? _buildNavIcon(Icons.monitor, 1, widget.onIndexSelected, widget.index) : Container(), // Planta
             _buildNavIcon(Icons.question_answer_outlined, 2, widget.onIndexSelected, widget.index), // Pregunta
            isSpecialist ? _buildNavIcon(Icons.reply, 7, widget.onIndexSelected, widget.index) : Container(),
            _buildNavIcon(Icons.person_outline_rounded, 4, widget.onIndexSelected, widget.index)
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