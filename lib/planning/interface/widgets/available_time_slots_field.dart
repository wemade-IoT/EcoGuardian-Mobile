import 'package:flutter/material.dart';
import 'package:ecoguardian/config/theme/app_theme.dart';

class AvailableTimeSlotsField extends StatelessWidget {
  final String? selectedSlot;
  final ValueChanged<String> onSlotSelected;

  static const List<String> timeSlots = [
    '9:00 am - 10:00 am',
    '10:00 am - 11:00 am',
    '11:00 am - 12:00 pm',
    '12:00 pm - 1:00 pm',
    '1:00 pm - 2:00 pm',
    '2:00 pm - 3:00 pm',
    '3:00 pm - 4:00 pm',
  ];

  const AvailableTimeSlotsField({
    super.key,
    required this.selectedSlot,
    required this.onSlotSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select a time slot:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: CustomColors.primary),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: timeSlots.map((slot) {
            final bool isSelected = slot == selectedSlot;
            return ChoiceChip(
              label: Text(slot),
              selected: isSelected,
              onSelected: (_) => onSlotSelected(slot),
              selectedColor: CustomColors.primary,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : CustomColors.darkGreen,
                fontWeight: FontWeight.bold,
              ),
              backgroundColor: CustomColors.fieldGrey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: isSelected ? CustomColors.primary : CustomColors.grey,
                  width: 1.5,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
