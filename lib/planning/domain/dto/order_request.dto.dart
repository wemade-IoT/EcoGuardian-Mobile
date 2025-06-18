class OrderDetailDto {
  final int deviceId;
  final int quantity;
  final double unitPrice;
  final String description;
  final double area;

  OrderDetailDto({
    required this.deviceId,
    required this.quantity,
    required this.unitPrice,
    required this.description,
    required this.area,
  });

  Map<String, dynamic> toJson() => {
        'deviceId': deviceId,
        'quantity': quantity,
        'unitPrice': unitPrice,
        'description': description,
        'area': area,
      };
}

class OrderRequestDto {
  final String action;
  final int consumerId;
  final DateTime installationDate;
  final List<OrderDetailDto> details;

  OrderRequestDto({
    required this.action,
    required this.consumerId,
    required this.installationDate,
    required this.details,
  });

  Map<String, dynamic> toJson() => {
        'action': action,
        'consumerId': consumerId,
        'installationDate': installationDate.toIso8601String(),
        'details': details.map((d) => d.toJson()).toList(),
      };
}

