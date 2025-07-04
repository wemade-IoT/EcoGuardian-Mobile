import 'package:ecoguardian/monitoring/domain/dto/plant.dto.dart';
import 'package:ecoguardian/monitoring/infrastructure/services/plant.service.dart';
import 'package:ecoguardian/shared/infrastructure/utils/serializable.dart';
import 'package:flutter/cupertino.dart';

class PlantProvider extends ChangeNotifier{
   List<PlantDto> _plants = [];
   PlantDto? selectedPlant;
   PlantService plantService = PlantService(resourcePath: "plant");
   get plants => _plants;

   Future<void> getPlantsByUserId(int userId) async{
      final data = await plantService.getPlantsByUserId(userId);
       _plants = data;
       notifyListeners();
   }

   void selectPlant(PlantDto plantDto){
     selectedPlant = plantDto;
     notifyListeners();
   }

   Future<int> createPlant(PlantDto plantDto) async{
      final response =  await plantService.createPlant(plantDto);
      if (response['id'] == null) {
        throw Exception("Plant creation failed, no ID returned.");
      }

      print(response);

      return response['id'] as int;
   }

   Future<void> deletePlant(PlantDto plantDto) async{
     await plantService.delete(plantDto.id);
   }

   Future<void> updatePlant(PlantDto plantDto) async{
     await plantService.put(plantDto.id, plantDto);
   }

   String? validateName(String value){
     if (value.isEmpty) {
       return 'Name is required';
     }
     return null;
   }

   String? validateType(String value){
     if (value.isEmpty) {
       return 'Type is required';
     }
     return null;
   }

   String? validateThresholds(String value){
     if(value.isEmpty){
       return "This threshold is required";
     }
     try {
       int parsedValue = int.parse(value);
       if (parsedValue == 0) {
         return "Threshold must be greater than 0";
       }
       else if (parsedValue > 100){
         return "Threshold must be lower or equal than 100";
       }
     } catch (e) {
       return "Please enter a valid number";
     }

     return null;
   }

   String? validateAreaCoverage(String value){
     if (value.isEmpty){
       return "Area coverage is required";
     }
     try {
       int parsedValue = int.parse(value);
       if (parsedValue == 0) {
         return "Area coverage must be greater than 0";
       }
       else if (parsedValue > 2){
         return "Area coverage cannot be greater than 2 km";
       }
     } catch (e) {
       return "Please enter a valid number";
     }

     return null;
   }


}