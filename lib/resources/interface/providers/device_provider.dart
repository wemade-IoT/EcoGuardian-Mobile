import 'package:ecoguardian/resources/domain/dto/device.dto.dart';
import 'package:ecoguardian/resources/infrastructure/services/device.service.dart';
import 'package:flutter/material.dart';

class DeviceProvider extends ChangeNotifier{

  Future<List<DeviceDto>> getDevicesByPlantId(int plantId) async{
    try{
     final deviceService = DeviceService(resourcePath: "devices?plantId=$plantId");
     final response = await deviceService.getByParam();
     return response.map((json) => DeviceDto.fromJson(json)).toList();
    } catch (e){
      throw Exception(e);
    }
  }
}