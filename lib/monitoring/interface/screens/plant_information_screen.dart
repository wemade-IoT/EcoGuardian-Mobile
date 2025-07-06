import 'package:ecoguardian/config/theme/app_theme.dart';
import 'package:ecoguardian/monitoring/domain/dto/plant.dto.dart';
import 'package:ecoguardian/monitoring/interface/widgets/plant_dialog.dart';
import 'package:ecoguardian/shared/infrastructure/helpers/date_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlantInformationScreen extends StatelessWidget {
  final PlantDto plantDto;
  static const String name = "plant_information";
  const PlantInformationScreen({super.key, required this.plantDto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Card(
          color: CustomColors.lightGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 10, // Sombra para profundidad
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Imagen de la planta (usamos la URL proporcionada)
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                   plantDto.imageUrl!,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20), // Espaciado entre imagen y título

                // Título de la información
                Text(
                  "Plant Information",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: CustomColors.darkGreen,
                  ),
                ),
                SizedBox(height: 10),

                // Nombre de la planta con icono
                Text(
                  "Name: ${plantDto.name}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: CustomColors.darkGreen,
                  ),
                ),
                SizedBox(height: 10),

                // Tipo de planta con icono
                Text(
                  "Type: ${plantDto.type}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: CustomColors.darkGreen,
                  ),
                ),
                SizedBox(height: 10),

                // Area de cobertura
                Row(
                  children: [
                    Icon(Icons.map, color: CustomColors.darkGreen),
                    SizedBox(width: 5),
                    Text(
                      "Area Coverage: ${plantDto.areaCoverage} km",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: CustomColors.darkGreen,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20), // Espaciado

                // Current Thresholds (usamos un Row para las secciones de thresholds)
                Text(
                  "Current Thresholds",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: CustomColors.darkGreen,
                  ),
                ),
                SizedBox(height: 10),
                Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildThresholdRow(Icons.water, "Humidity", "${plantDto.waterThreshold}%"),
                    _buildThresholdRow(Icons.thermostat, "Temperature", "${plantDto.temperatureThreshold}°C"),
                    _buildThresholdRow(Icons.lightbulb, "Light", "${plantDto.temperatureThreshold}%"),
                  ],
                ),
                SizedBox(height: 30), // Espaciado

                // Información de actividad
                Text(
                  "Activity",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: CustomColors.darkGreen,
                  ),
                ),
                SizedBox(height: 10),

                // Fechas de actividad
                Text(
                  "Added At: ${formatDate(plantDto.createdAt)}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: CustomColors.grey,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Last Updated: ${formatDate(plantDto.updatedAt!)} ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: CustomColors.grey,
                  ),
                ),
                SizedBox(height: 30),

                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return PlantDialog(plant: plantDto);
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: CustomColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 30),
                      elevation: 5,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.edit, color: Colors.white, size: 18),
                        SizedBox(width: 10),
                        Text(
                          'Edit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThresholdRow(IconData icon, String label, String value) {
    return  Row(
        children: [
          Icon(icon, color: CustomColors.darkGreen),
          SizedBox(width: 5),
          Text(
            "$label: $value",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: CustomColors.darkGreen,
            ),
          ),
        ],
    );
  }
}
