import 'package:ecoguardian/monitoring/domain/dto/plant.dto.dart';
import 'package:ecoguardian/planning/domain/dto/order_detail.dto.dart';
import 'package:flutter/material.dart';
import 'package:ecoguardian/config/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import '../providers/order_provider.dart';
import '../widgets/date_picker_field.dart';
import '../widgets/available_time_slots_field.dart';

class InstallationScreen extends StatefulWidget {
  final PlantDto plant;

  static const String name = 'installation_screen';

  const InstallationScreen({super.key, required this.plant});

  @override
  State<InstallationScreen> createState() => _InstallationScreenState();
}

class _InstallationScreenState extends State<InstallationScreen> {
  DateTime? _selectedDate;
  String? _selectedSlot;

  @override
  void initState() {
    print("Selected plant: ${widget.plant.image}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Sección de fecha
                    _buildSectionCard(
                      icon: Icons.calendar_today,
                      title: 'Selecciona la Fecha',
                      subtitle: 'Elige el día que mejor se adapte a tu horario',
                      child: DatePickerField(
                        initialDate: _selectedDate,
                        onDateSelected: (date) {
                          setState(() {
                            _selectedDate = date;
                          });
                        },
                        label: 'Fecha de Instalación',
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Sección de horario
                    _buildSectionCard(
                      icon: Icons.access_time,
                      title: 'Horarios Disponibles',
                      subtitle: 'Selecciona el horario que prefieras',
                      child: AvailableTimeSlotsField(
                        selectedSlot: _selectedSlot,
                        onSlotSelected: (slot) {
                          setState(() {
                            _selectedSlot = slot;
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Resumen de selección
                    if (_selectedDate != null && _selectedSlot != null)
                      _buildSummaryCard(),

                    const SizedBox(height: 32),

                    // Botones de acción
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              context.push('/monitoring');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade600,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 3,
                            ),
                            child: const Text(
                              'Cancelar',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _selectedDate != null && _selectedSlot != null
                                ? () {
                                    final combinedDateTime = _combineDateAndTimeSlot(
                                      _selectedDate!,
                                      _selectedSlot!,
                                    );

                                    context.push(
                                      "/order-detail?installationDate=${combinedDateTime.toIso8601String()}",
                                      extra: widget.plant,
                                    );
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: CustomColors.primary,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              elevation: _selectedDate != null && _selectedSlot != null ? 3 : 1,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Continuar',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: _selectedDate != null && _selectedSlot != null
                                        ? Colors.white
                                        : Colors.white70,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: CustomColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: CustomColors.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Card(
      elevation: 1,
      color: Colors.green.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.green.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green.shade600,
                  size: 24,
                ),
                const SizedBox(width: 12),
                const Text(
                  'Resumen de tu Cita',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildSummaryRow(
              Icons.calendar_today,
              'Fecha',
              '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
            ),
            const SizedBox(height: 8),
            _buildSummaryRow(
              Icons.access_time,
              'Horario',
              _selectedSlot!,
            ),
            _buildSummaryRow(
              Icons.local_florist,
              'Planta',
              widget.plant.name ?? 'Sin nombre',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

// baila mati
DateTime _combineDateAndTimeSlot(DateTime date, String timeSlot) {
  // Extraer la hora del slot
  final startTime = timeSlot.split(' - ')[0];
  final timeParts = startTime.split(':');
  int hour = int.parse(timeParts[0]);
  int minute = int.parse(timeParts[1].split(' ')[0]);

  // Manejar AM/PM
  final period = startTime.contains('PM') ? 'PM' : 'AM';
  if (period == 'PM' && hour != 12) {
    hour += 12;
  } else if (period == 'AM' && hour == 12) {
    hour = 0;
  }

  return DateTime(date.year, date.month, date.day, hour, minute);
}