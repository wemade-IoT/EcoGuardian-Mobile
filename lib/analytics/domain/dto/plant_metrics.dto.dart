class WaterMetricDto {
  final double value;
  final String description;

  WaterMetricDto({required this.value, required this.description});

  factory WaterMetricDto.fromJson(Map<String, dynamic> json) {
    return WaterMetricDto(
      value: (json['value'] as num).toDouble(),
      description: json['description'] ?? '',
    );
  }
}

class LightMetricDto {
  final double value;
  final String description;

  LightMetricDto({required this.value, required this.description});

  factory LightMetricDto.fromJson(Map<String, dynamic> json) {
    return LightMetricDto(
      value: (json['value'] as num).toDouble(),
      description: json['description'] ?? '',
    );
  }
}

class HumidityMetricDto {
  final double value;
  final String description;

  HumidityMetricDto({required this.value, required this.description});

  factory HumidityMetricDto.fromJson(Map<String, dynamic> json) {
    return HumidityMetricDto(
      value: (json['value'] as num).toDouble(),
      description: json['description'] ?? '',
    );
  }
}

