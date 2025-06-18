import 'package:dio/dio.dart';
import 'package:ecoguardian/analytics/domain/dto/plant_metrics.dto.dart';

class PlantMetricsService {
  static const String BASE_URL = "http://localhost:9080/api/v1/";
  final Dio _dio;

  PlantMetricsService() : _dio = Dio(BaseOptions(
    baseUrl: BASE_URL,
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

