import 'package:flutter/material.dart';
import 'package:ecoguardian/config/theme/app_theme.dart';
import '../../domain/dto/order_request.dto.dart';
import '../providers/order_provider.dart';
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
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    // TODO: Replace with actual values from the app
                    final order = OrderRequestDto(
                      action: 'plant',
                      consumerId: 1, // Replace with actual consumerId
                      installationDate: _selectedDate ?? DateTime.now(),
                      details: [
                        OrderDetailDto(
                          deviceId: 1,
                          quantity: 1,
                          unitPrice: 100.0,
                          description: '',
                          area: 10.0,
                        ),
                      ],
                    );
                    try {
                      final provider = OrderProvider();
                      await provider.createOrder(order);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Order created successfully!')),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to create order: $e')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: const Text(
                    'Submit Order',
                    style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}