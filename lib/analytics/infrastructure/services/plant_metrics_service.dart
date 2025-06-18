import 'package:dio/dio.dart';
import 'package:ecoguardian/analytics/domain/dto/plant_metrics.dto.dart';

import '../../../config/constants/constant.dart';

class PlantMetricsService {
  final Dio _dio;

  PlantMetricsService() : _dio = Dio(BaseOptions(
    baseUrl: Constant.baseUrl,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  Future<WaterMetricDto> getWaterMetric() async {
    final response = await _dio.get("water");
    return WaterMetricDto.fromJson(response.data);
  }

  Future<LightMetricDto> getLightMetric() async {
    final response = await _dio.get("light");
    return LightMetricDto.fromJson(response.data);
  }

  Future<HumidityMetricDto> getHumidityMetric() async {
    final response = await _dio.get("humidity");
    return HumidityMetricDto.fromJson(response.data);
  }
}

