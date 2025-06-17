import 'package:flutter/material.dart';
import 'package:ecoguardian/config/theme/app_theme.dart';

class DatePickerField extends StatefulWidget {
  final DateTime? initialDate;
  final ValueChanged<DateTime> onDateSelected;
  final String label;

  const DatePickerField({
    super.key,
    this.initialDate,
    required this.onDateSelected,
    this.label = 'Date',
  });

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  late TextEditingController _controller;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _controller = TextEditingController(
      text: _selectedDate != null
          ? "${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}"
          : '',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
      helpText: 'Select a date',
      locale: const Locale('en'),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _controller.text = "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
      widget.onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextField(
        controller: _controller,
        readOnly: true,
        onTap: () => _pickDate(context),
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: const TextStyle(color: CustomColors.primary),
          suffixIcon: const Icon(Icons.calendar_today, color: CustomColors.primary),
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: CustomColors.primary, width: 2),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: CustomColors.fieldGrey),
          ),
          fillColor: CustomColors.fieldGrey,
          filled: true,
        ),
        style: const TextStyle(color: CustomColors.darkGreen),
      ),
    );
  }
}
