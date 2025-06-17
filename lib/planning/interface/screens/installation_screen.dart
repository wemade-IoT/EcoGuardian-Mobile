import 'package:flutter/material.dart';
import '../widgets/date_picker_field.dart';
import '../widgets/available_time_slots_field.dart';

class InstallationScreen extends StatefulWidget {

  static const String name = 'installation_screen';

  const InstallationScreen({super.key});

  @override
  State<InstallationScreen> createState() => _InstallationScreenState();
}

class _InstallationScreenState extends State<InstallationScreen> {
  DateTime? _selectedDate;
  String? _selectedSlot;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Selecciona la fecha de instalación:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),
          DatePickerField(
            initialDate: _selectedDate,
            onDateSelected: (date) {
              setState(() {
                _selectedDate = date;
              });
            },
            label: 'Fecha',
          ),
          const SizedBox(height: 32),
          AvailableTimeSlotsField(
            selectedSlot: _selectedSlot,
            onSlotSelected: (slot) {
              setState(() {
                _selectedSlot = slot;
              });
            },
          ),
        ],
      ),
    );
  }
}