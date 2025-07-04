import 'package:ecoguardian/shared/infrastructure/utils/serializable.dart';

class DeviceDto with Serializable {
  final int? id;
  final String type;
  final double voltage;
  final int? deviceStateId;
  final int plantId;
  final DateTime? activatedAt;
  final DateTime? deactivatedAt;

  DeviceDto({
    this.id,
    required this.type,
    required this.voltage,
    this.deviceStateId,
    required this.plantId,
    this.activatedAt,
    this.deactivatedAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'voltage': voltage,
    'deviceStateId': deviceStateId,
    'plantId': plantId,
    'activatedAt': activatedAt?.toIso8601String(),
    'deactivatedAt': deactivatedAt?.toIso8601String(),
  };

  @override
  Map<String, dynamic> toRequest() => {
    'type': type,
    'voltage': voltage,
    'plantId': plantId,
  };

  factory DeviceDto.fromJson(Map<String, dynamic> json) {
    return DeviceDto(
      id: json['id'],
      type: json['type'],
      voltage: (json['voltage'] as num).toDouble(),
      deviceStateId: json['deviceStateId'],
      plantId: json['plantId'],
      activatedAt:
          json['activatedAt'] != null
              ? DateTime.parse(json['activatedAt'])
              : null,
      deactivatedAt:
          json['deactivatedAt'] != null
              ? DateTime.parse(json['deactivatedAt'])
              : null,
    );
  }
}
