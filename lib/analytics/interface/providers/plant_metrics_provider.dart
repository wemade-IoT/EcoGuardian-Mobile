import 'package:flutter/material.dart';
import 'package:ecoguardian/analytics/domain/dto/plant_metrics.dto.dart';
import 'package:ecoguardian/analytics/infrastructure/services/plant_metrics_service.dart';

class PlantMetricsProvider extends ChangeNotifier {
  final PlantMetricsService _service = PlantMetricsService();

  WaterMetricDto? waterMetric;
  LightMetricDto? lightMetric;
  HumidityMetricDto? humidityMetric;
  bool isLoading = false;
  String? error;

  Future<void> fetchMetrics() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      final results = await Future.wait([
        _service.getWaterMetric(),
        _service.getHumidityMetric(),
        _service.getLightMetric(),
      ]);
      waterMetric = results[0] as WaterMetricDto;
      humidityMetric = results[1] as HumidityMetricDto;
      lightMetric = results[2] as LightMetricDto;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

