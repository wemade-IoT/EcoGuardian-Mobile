import 'package:ecoguardian/shared/infrastructure/utils/serializable.dart';

class AnswerDto with Serializable{
  int? id;
  int? specialistId;
  int? questionId;
  String? questionTitle;
  String? answerText;
  DateTime? createdAt;


  AnswerDto({
    this.id,
    this.specialistId,
    this.questionId,
    this.questionTitle,
    this.answerText,
    this.createdAt
  });
  factory AnswerDto.fromJson(Map<String, dynamic> json) {
    return AnswerDto(
      id: json['id'] ?? 0,
      specialistId: json['specialistId'] ?? 0,
      questionId: json['questionId'] ?? 0,
      questionTitle: json['questionTitle'] ?? 0,
      answerText: json['answerText'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toRequest() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['specialistId'] = this.specialistId;
    data['answerText'] = this.answerText;
    return data;
  }
}