class Question {
  final int questionId;
  final String title;
  final String content;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int plantId;
  final int userId;
  final List<String> imageUrls;


  Question({required this.questionId, required this.title, required this.content, required this.status, required this.createdAt, required this.updatedAt, required this.plantId,required this.userId,required this.imageUrls});
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
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
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['plantId'] = this.plantId;
    data['userId'] = this.userId;
    data['imageUrls'] = this.imageUrls;
    return data;
  }
}