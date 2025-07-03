class NotificationDto {
  int? id;
  String? title;
  String? subject;
  int? profileId;
  String? createdAt;

  NotificationDto(
      {this.id, this.title, this.subject, this.profileId, this.createdAt});

  NotificationDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subject = json['subject'];
    profileId = json['profileId'];
    createdAt = json['createdAt'];
  }
  
}