class MetricRegistryDto {
  int? id;
  int? deviceId;
  String? createdAt;
  List<Metrics>? metrics;

  MetricRegistryDto({this.id, this.deviceId, this.createdAt, this.metrics});

  MetricRegistryDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deviceId = json['deviceId'];
    createdAt = json['createdAt'];
    if (json['metrics'] != null) {
      metrics = <Metrics>[];
      json['metrics'].forEach((v) {
        metrics!.add(Metrics.fromJson(v));
      });
    }
  }

}

class Metrics {
  int? id;
  double? metricValue;
  int? metricTypesId;

  Metrics({this.id, this.metricValue, this.metricTypesId});

  Metrics.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    metricValue = json['metricValue'];
    metricTypesId = json['metricTypesId'];
  }
}
