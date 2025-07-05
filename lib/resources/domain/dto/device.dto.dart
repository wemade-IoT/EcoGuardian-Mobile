class DeviceDto {
  int? id;
  String? type;
  int? voltage;
  int? deviceStateId;
  int? plantId;
  String? activatedAt;
  String? deactivatedAt;

  DeviceDto(
      {this.id,
        this.type,
        this.voltage,
        this.deviceStateId,
        this.plantId,
        this.activatedAt,
        this.deactivatedAt});

  DeviceDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    voltage = json['voltage'];
    deviceStateId = json['deviceStateId'];
    plantId = json['plantId'];
    activatedAt = json['activatedAt'];
    deactivatedAt = json['deactivatedAt'];
  }

}