class Answer {
  final int id;
  final int specialistId;
  final int questionId;
  final String questionTitle;
  final String answerText;
  final DateTime createdAt;


  Answer({ required this.id, required this.specialistId,required this.questionId,required this.questionTitle,required this.answerText,required this.createdAt});
  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'] ?? 0,
      specialistId: json['specialistId'] ?? 0,
      questionId: json['questionId'] ?? 0,
      questionTitle: json['questionTitle'] ?? 0,
      answerText: json['answerText'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['specialistId'] = this.specialistId;
    data['answerText'] = this.answerText;
    return data;
  }
}