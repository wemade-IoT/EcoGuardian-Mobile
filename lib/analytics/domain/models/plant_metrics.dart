class WaterMetric {
  final double value;
  final String description;

  WaterMetric({required this.value, required this.description});

  factory WaterMetric.fromJson(Map<String, dynamic> json) {
    return WaterMetric(
      value: (json['value'] as num).toDouble(),
      description: json['description'] ?? '',
    );
  }
}

class LightMetric {
  final double value;
  final String description;

  LightMetric({required this.value, required this.description});

  factory LightMetric.fromJson(Map<String, dynamic> json) {
    return LightMetric(
      value: (json['value'] as num).toDouble(),
      description: json['description'] ?? '',
    );
  }
}

class HumidityMetric {
  final double value;
  final String description;

  HumidityMetric({required this.value, required this.description});

  factory HumidityMetric.fromJson(Map<String, dynamic> json) {
    return HumidityMetric(
      value: (json['value'] as num).toDouble(),
      description: json['description'] ?? '',
    );
  }
}

