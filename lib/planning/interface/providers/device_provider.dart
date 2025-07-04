import 'package:ecoguardian/planning/domain/dto/device.dto.dart';
import 'package:ecoguardian/planning/infrastructure/services/device.service.dart';
import 'package:flutter/foundation.dart';

class DeviceProvider extends ChangeNotifier {
  final DeviceService deviceService = DeviceService(resourcePath: "devices");

  Future<int> createDevice(DeviceDto deviceDto) async {
    try {
      final response = await deviceService.createDevice(deviceDto);
      if (response['id'] == null) {
        throw Exception("Device creation failed, no ID returned.");
      }

      return response['id'] as int;
    } catch (e) {
      throw Exception("Error creating device: $e");
    }
  }

  Future<List<DeviceDto>> getDevicesByPlantId(int consumerId) async {
    try {
      final devices = await deviceService.getDevicesByPlantId(consumerId);
      return devices;
    } catch (e) {
      throw Exception("No devices available: $e");
    }
  }
}
