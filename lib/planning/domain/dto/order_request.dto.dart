import 'package:ecoguardian/planning/domain/dto/order_detail.dto.dart';
import 'package:ecoguardian/shared/infrastructure/utils/serializable.dart';

class OrderRequestDto with Serializable {
  final int? id;
  final String action;
  final int consumerId;
  final DateTime installationDate;
  final List<OrderDetailDto> details;
  final DateTime? createdAt;
  final DateTime? completedAt;
  final int? stateId;
  final int? specialistId;

  OrderRequestDto({
    this.id,
    required this.action,
    required this.consumerId,
    required this.installationDate,
    required this.details,
    this.createdAt,
    this.completedAt,
    this.stateId,
    this.specialistId,
  });

  factory OrderRequestDto.fromJson(Map<String, dynamic> json) {
    return OrderRequestDto(
      id: json['id'],
      action: json['action'],
      consumerId: json['consumerId'],
      installationDate: DateTime.parse(json['installationDate']),
      details: (json['details'] as List)
          .map((detail) => OrderDetailDto.fromJson(detail))
          .toList(),
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      completedAt: json['completedAt'] != null ? DateTime.parse(json['completedAt']) : null,
      stateId: json['stateId'],
      specialistId: json['specialistId'],
    );
  }

  @override
  Map<String, dynamic> toRequest() => {
        'action': action,
        'consumerId': consumerId,
        'installationDate': installationDate.toIso8601String(),
        'details': details.map((d) => d.toJson()).toList(),
      };
}