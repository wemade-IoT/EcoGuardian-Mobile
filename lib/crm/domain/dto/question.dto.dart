import 'package:ecoguardian/shared/infrastructure/utils/serializable.dart';
import 'package:image_picker/image_picker.dart';

class QuestionDto with Serializable {
  int? questionId;
  String? title;
  String? content;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? plantId;
  int? userId;
  List<XFile>? images;
  List<String>? imageUrls;


  QuestionDto({
    this.questionId,
    this.title,
    this.content,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.plantId,
    this.userId,
    this.imageUrls,
    this.images
  });
  factory QuestionDto.fromJson(Map<String, dynamic> json) {
    return QuestionDto(
      questionId: json['questionId'] ?? 0,
      title: json['title'] ?? '',
      status: json['status'] ?? '',
      content: json['content'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      plantId: json['plantId'] ?? 0,
      userId: json['userId'] ?? 0,
      imageUrls: List<String>.from(json['imageUrls']),
    );
  }
  @override
  Map<String, dynamic> toRequest() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = this.title;
    data['content'] = this.content;
    data['plantId'] = this.plantId;
    data['userId'] = this.userId;
    data['imageUrls'] = this.images;
    return data;
  }
}