import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
//import 'package:url_launcher/url_launcher.dart';

class OrderCreatedSuccessfullyDialog extends StatelessWidget {
  const OrderCreatedSuccessfullyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Evita que se cierre con el botón de atrás
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icono de éxito con animación
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green.shade100,
                  border: Border.all(color: Colors.green.shade300, width: 3),
                ),
                child: Icon(
                  Icons.check_circle,
                  size: 50,
                  color: Colors.green.shade600,
                ),
              ),
              const SizedBox(height: 24),
              
              // Título
              const Text(
                '¡Orden Registrada!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              
              // Mensaje descriptivo
              Text(
                'Tu orden ha sido registrada exitosamente. Para confirmar la instalación, debes completar el pago en nuestra plataforma web.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              
              // Información adicional
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.blue.shade700,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Selecciona una opción para continuar con el proceso.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              
              // Botones
              Row(
                children: [
                  // Botón para ir al historial
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        context.go('/order-history');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade600,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        'Ver Historial',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  
                  // Botón para ir a la plataforma web
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        // implementar esta bailecito
                        /* final Uri url = Uri.parse('https://tu-plataforma-web.com/payment');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url, mode: LaunchMode.externalApplication);
                        } else {
                          // Fallback si no se puede abrir el link
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('No se pudo abrir la página web'),
                            ),
                          );
                        } */
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade600,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        'Pagar Ahora',
                        style: TextStyle(
                          fontSize: 16,
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
}