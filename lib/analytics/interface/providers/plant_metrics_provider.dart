import 'package:flutter/material.dart';
import 'package:ecoguardian/analytics/domain/dto/plant_metrics.dto.dart';
import 'package:ecoguardian/analytics/infrastructure/services/plant_metrics_service.dart';

class PlantMetricsProvider extends ChangeNotifier {
  bool isLoading = false;
  Future<List<MetricRegistryDto>> fetchMetrics(int deviceId) async {
    isLoading = true;
   try{
     final service = PlantMetricsService(resourcePath: 'metric-registry?deviceId=$deviceId&period=hourly');
     final response = await service.getByParam();
     isLoading = false;
     notifyListeners();
     return response.map((json) => MetricRegistryDto.fromJson(json)).toList();

   } catch (e){
     isLoading = false;
     notifyListeners();
     throw Exception(e);
   }
  }


  Future<MetricRegistryDto> fetchLatestMetrics(int deviceId) async {
    isLoading = true;
    try{
      final service = PlantMetricsService(resourcePath: 'metric-registry/devices/$deviceId/latest');
      final response = await service.getByIdV2();
      isLoading = false;
      notifyListeners();
      return MetricRegistryDto.fromJson(response);

    } catch (e){
      isLoading = false;
      notifyListeners();
      throw Exception(e);
    }
  }
}

