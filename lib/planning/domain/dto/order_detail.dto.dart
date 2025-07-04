import 'package:ecoguardian/shared/infrastructure/utils/serializable.dart';

class OrderDetailDto with Serializable {
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

  // Método para convertir a JSON
  Map<String, dynamic> toJson() => {
        'deviceId': deviceId,
        'quantity': quantity,
        'unitPrice': unitPrice,
        'description': description,
        'area': area,
      };

  // Método para convertir a formato de solicitud HTTP
  @override
  Map<String, dynamic> toRequest() => {
        'deviceId': deviceId,
        'quantity': quantity,
        'unitPrice': unitPrice,
        'description': description,
        'area': area,
      };

  // Método para crear una instancia desde JSON
  factory OrderDetailDto.fromJson(Map<String, dynamic> json) {
    return OrderDetailDto(
      deviceId: json['deviceId'],
      quantity: json['quantity'],
      unitPrice: (json['unitPrice'] as num).toDouble(),
      description: json['description'],
      area: (json['area'] as num).toDouble(),
    );
  }
}