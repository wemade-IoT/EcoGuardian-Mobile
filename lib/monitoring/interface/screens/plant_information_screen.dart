import 'package:ecoguardian/config/theme/app_theme.dart';
import 'package:ecoguardian/monitoring/domain/dto/plant.dto.dart';
import 'package:ecoguardian/monitoring/interface/widgets/plant_dialog.dart';
import 'package:ecoguardian/monitoring/interface/widgets/plant_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlantInformationScreen extends StatelessWidget {
  final PlantDto plantDto;
  static const String name = "plant_information";
  const PlantInformationScreen({super.key, required this.plantDto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Card(
          color: CustomColors.lightGreen,
          child: Container(
            height: 350,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              spacing: 20,
              children: [
                PlantSection(label: "Name", value: plantDto.name),
                PlantSection(label: "Type", value: plantDto.type),
                PlantSection(label: "WaterThreshold", value: plantDto.waterThreshold.toString()),
                PlantSection(label: "LightThreshold", value:plantDto.lightThreshold.toString()),
                PlantSection(label: "TemperatureThreshold", value: plantDto.temperatureThreshold.toString()),
                PlantSection(label: "Created at:", value: DateFormat('dd/MM/yyyy').format(plantDto.createdAt)),
                PlantSection(label: "Last Update:", value: DateFormat('dd/MM/yyyy').format(plantDto.createdAt)),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      color: CustomColors.primary,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: IconButton(
                      color: Colors.white,
                        onPressed: () async{
                          await showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return PlantDialog(plant: plantDto);
                              }
                          );
                    },
                        icon: Icon(Icons.edit)
                    ),
                  )
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
