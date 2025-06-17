import 'package:flutter/material.dart';
import 'package:ecoguardian/config/theme/app_theme.dart';
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select installation date:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: CustomColors.primary,
                ),
              ),
              const SizedBox(height: 16),
              DatePickerField(
                initialDate: _selectedDate,
                onDateSelected: (date) {
                  setState(() {
                    _selectedDate = date;
                  });
                },
                label: 'Date',
              ),
              const SizedBox(height: 32),
              Material(
                color: Colors.transparent,
                child: AvailableTimeSlotsField(
                  selectedSlot: _selectedSlot,
                  onSlotSelected: (slot) {
                    setState(() {
                      _selectedSlot = slot;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}