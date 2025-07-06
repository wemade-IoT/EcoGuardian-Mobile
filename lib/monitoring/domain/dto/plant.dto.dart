import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../../../shared/infrastructure/utils/serializable.dart';

class PlantDto with Serializable {
  final int id;
  final String name;
  XFile? image;
  String? imageUrl;
  final String type;
  final bool isPlantation;
  final int areaCoverage;
  final int userId;
  final int waterThreshold;
  final int temperatureThreshold;
  final int lightThreshold;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final int stateId;

  PlantDto({
    required this.name,
     this.image,
    this.imageUrl,
    required this.id,
    required this.type,
    required this.isPlantation,
    required this.areaCoverage,
    required this.userId,
    required this.waterThreshold,
    required this.temperatureThreshold,
    required this.lightThreshold,
    required this.createdAt,
    required this.updatedAt,
    required this.stateId,
  });

  factory PlantDto.fromJson(Map<String, dynamic> json) {
    return PlantDto(
      id: json["id"],
      name: json["name"],
      imageUrl: json["image"],
      type: json["type"],
      isPlantation: json["isPlantation"],
      areaCoverage: json["areaCoverage"],
      userId: json["userId"],
      waterThreshold: json["waterThreshold"],
      lightThreshold: json["lightThreshold"],
      temperatureThreshold: json["temperatureThreshold"],
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: json["updatedAt"] != null
          ? DateTime.parse(json["updatedAt"])
          : DateTime(1970, 1, 1),
      stateId: json["wellnessStateId"],
    );
  }

  @override
  Map<String, dynamic> toRequest() {
    return {
      "id": id,
      "name":name,
      "image": image,
      "type": type,
      "isPlantation": isPlantation,
      "areaCoverage": areaCoverage,
      "userId": userId,
      "waterThreshold": waterThreshold,
      "temperatureThreshold": temperatureThreshold,
      "wellnessStateId": stateId,
    };
  }
}
