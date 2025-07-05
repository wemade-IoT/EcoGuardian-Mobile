import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ecoguardian/config/theme/app_theme.dart';
import 'package:ecoguardian/config/constants/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ErrorPage extends StatelessWidget {
  final String? errorMessage;
  final String? errorCode;
  final VoidCallback? onRetry;

  const ErrorPage({
    super.key,
    this.errorMessage,
    this.errorCode,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: CustomColors.lightGrey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icono principal de error
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: CustomColors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: CustomColors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(
                  FontAwesomeIcons.triangleExclamation,
                  size: 60,
                  color: CustomColors.primary,
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Título principal
              Text(
                '¡Ups! Algo salió mal',
                style: textTheme.headlineSmall?.copyWith(
                  color: CustomColors.darkGreen,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 16),
              
              // Mensaje de error
              Text(
                errorMessage ?? 
                'Parece que hemos encontrado un problema. No te preocupes, nuestro equipo está trabajando para solucionarlo.',
                style: textTheme.bodyLarge?.copyWith(
                  color: CustomColors.grey,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              
              // Código de error (si existe)
              if (errorCode != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: CustomColors.lightGreen,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Código de error: $errorCode',
                    style: textTheme.bodySmall?.copyWith(
                      color: CustomColors.darkGreen,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
              
              const SizedBox(height: 48),
              
              // Ilustración ecológica
              Container(
                width: size.width * 0.6,
                height: 120,
                decoration: BoxDecoration(
                  color: CustomColors.lightGreen,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.seedling,
                      size: 40,
                      color: CustomColors.primary,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Cuidando el planeta',
                      style: textTheme.bodyMedium?.copyWith(
                        color: CustomColors.darkGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'mientras solucionamos esto',
                      style: textTheme.bodySmall?.copyWith(
                        color: CustomColors.mediumGreen,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 48),
              
              // Botones de acción
              Row(
                children: [
                  // Botón de reintentar
                  if (onRetry != null) ...[
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: onRetry,
                        icon: const Icon(FontAwesomeIcons.arrowRotateRight),
                        label: const Text('Reintentar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColors.primary,
                          foregroundColor: CustomColors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                  
                  // Botón de volver al inicio
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => context.go(Constant.homePath),
                      icon: const Icon(FontAwesomeIcons.house),
                      label: const Text('Ir al inicio'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.white,
                        foregroundColor: CustomColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: CustomColors.primary,
                            width: 2,
                          ),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Información adicional
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: CustomColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: CustomColors.lightTeal,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.circleInfo,
                      size: 20,
                      color: CustomColors.teal,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Si el problema persiste, contacta a nuestro equipo de soporte.',
                        style: textTheme.bodySmall?.copyWith(
                          color: CustomColors.grey,
                        ),
                      ),
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
}

// Página de error 404 específica
class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: CustomColors.lightGrey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Número 404 estilizado
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: CustomColors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: CustomColors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      '404',
                      style: textTheme.displayLarge?.copyWith(
                        color: CustomColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Icon(
                      FontAwesomeIcons.magnifyingGlass,
                      size: 32,
                      color: CustomColors.mediumGreen,
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              Text(
                'Página no encontrada',
                style: textTheme.headlineSmall?.copyWith(
                  color: CustomColors.darkGreen,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 16),
              
              Text(
                'La página que buscas no existe o ha sido movida. Vamos a llevarte de vuelta a casa.',
                style: textTheme.bodyLarge?.copyWith(
                  color: CustomColors.grey,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 48),
              
              // Botón para volver
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => context.go(Constant.homePath),
                  icon: const Icon(FontAwesomeIcons.house),
                  label: const Text('Volver al inicio'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.primary,
                    foregroundColor: CustomColors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
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
