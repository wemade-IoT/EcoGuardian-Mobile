import 'package:ecoguardian/monitoring/domain/dto/plant.dto.dart';
import 'package:ecoguardian/monitoring/interface/providers/plant_provider.dart';
import 'package:ecoguardian/planning/domain/dto/device.dto.dart';
import 'package:ecoguardian/planning/domain/dto/order_detail.dto.dart';
import 'package:ecoguardian/planning/domain/dto/order_request.dto.dart';
import 'package:ecoguardian/planning/interface/providers/device_provider.dart';
import 'package:ecoguardian/planning/interface/providers/order_provider.dart';
import 'package:ecoguardian/planning/interface/widgets/order_created_successfully_dialog.dart';
import 'package:ecoguardian/planning/interface/widgets/plant_preview_dialog.dart';
import 'package:ecoguardian/shared/infrastructure/helpers/storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class OrderDetailScreen extends StatefulWidget {
  final DateTime installationDate;
  final PlantDto plant;

  static const String name = 'orden_detail_screen';

  const OrderDetailScreen({
    super.key,
    required this.plant,
    required this.installationDate,
  });

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  void initState() {
    print("Selected plant: ${widget.plant.image?.name}");
    print("Installation date: ${widget.installationDate}");
    super.initState();
  }

  Future<void> _createOrder() async {
    final plantProvider = Provider.of<PlantProvider>(context, listen: false);
    final deviceProvider = Provider.of<DeviceProvider>(context, listen: false);
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    final userId = await StorageHelper.getUserId();

    try {
      // mas carajeado esto XD (no entendi la bisness logic)
      final plantId = await plantProvider.createPlant(
        PlantDto(
          name: widget.plant.name, 
          id: 0, 
          image: widget.plant.image,
          type: widget.plant.type, 
          isPlantation: widget.plant.isPlantation, 
          areaCoverage: widget.plant.areaCoverage, 
          userId: userId!, 
          waterThreshold: widget.plant.waterThreshold, 
          temperatureThreshold: widget.plant.temperatureThreshold, 
          lightThreshold: widget.plant.lightThreshold, 
          createdAt: widget.plant.createdAt, 
          updatedAt: widget.plant.updatedAt, 
          stateId: widget.plant.stateId
        )
      );
      final deviceId = await deviceProvider.createDevice(
        DeviceDto(type: 'ESP32', voltage: 20, plantId: plantId),
      );

      await orderProvider.createOrder(
        OrderRequestDto(
          action: 'create',
          consumerId: userId!,
          installationDate: widget.installationDate,
          details: [
            OrderDetailDto(
              deviceId: deviceId,
              quantity: 1,
              unitPrice: 100.00,
              description: 'Kit de sensores para ${widget.plant.name}',
              area: widget.plant.areaCoverage.toDouble(),
            ),
          ],
        ),
      );

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const OrderCreatedSuccessfullyDialog(),
      );
    } catch (e) {
      // Handle any errors that occur during order creation
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error creating order: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: true,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Registro de Nueva Planta',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.green.shade200,
                        width: 2,
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder:
                                (context) => PlantPreviewDialog(
                                  plant: widget.plant,
                                  installationDate: widget.installationDate,
                                ),
                          );
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Icon(
                            Icons.local_florist,
                            color: Colors.green.shade600,
                            size: 26,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    spacing: 20.0,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Kit de Sensores Incluido',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      _buildSensorRow(
                        icon: Icons.water_drop,
                        color: Colors.blue,
                        title: 'Sensor de Humedad',
                        description: 'Monitoreo de humedad del suelo',
                        price: 'S/. 35.00',
                      ),

                      _buildSensorRow(
                        icon: Icons.wb_sunny,
                        color: Colors.orange,
                        title: 'Sensor de Luz',
                        description: 'Medición de intensidad lumínica',
                        price: 'S/. 40.00',
                      ),

                      _buildSensorRow(
                        icon: Icons.thermostat,
                        color: Colors.red,
                        title: 'Sensor de Temperatura',
                        description: 'Control de temperatura ambiental',
                        price: 'S/. 25.00',
                      ),

                      const Divider(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total del Kit:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'S/. 100.00',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Detalles de Instalación',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),

                      Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.green.shade50,
                          border: Border.all(color: Colors.green.shade200),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.build_circle,
                              size: 48,
                              color: Colors.green.shade600,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Instalación Profesional',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.green.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      _buildScheduleRow(
                        icon: Icons.calendar_today,
                        title: 'Fecha de Instalación',
                        value: 'Lunes, 15 de Julio 2024',
                      ),
                      const SizedBox(height: 16),
                      _buildScheduleRow(
                        icon: Icons.access_time,
                        title: 'Hora de Instalación',
                        value: '10:00 AM - 12:00 PM',
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              Row(
                children: [
                  // Botón para cancelar
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context.push('/monitoring');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.withOpacity(0.8),
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
                  // Botón para crear orden
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        // Mostrar indicador de carga
                        await _createOrder();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade600,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                      ),
                      child: const Text(
                        'Crear Orden',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSensorRow({
    required IconData icon,
    required Color color,
    required String title,
    required String description,
    required String price,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            // ignore: deprecated_member_use (zilito)
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        Text(
          price,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _buildScheduleRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.green.shade600, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
