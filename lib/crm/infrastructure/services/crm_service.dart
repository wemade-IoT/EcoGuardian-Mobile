import 'package:dio/dio.dart';

import '../../domain/models/answer.dart';
import '../../domain/models/question.dart';

class CRMService{
  static const String BASE_URL = "http://localhost:9080/api/v1/";

  final Dio _dio;

  CRMService() : _dio = Dio(BaseOptions(
    baseUrl: BASE_URL,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  Future<List<Question>> getQuestions() async {
    final response = await _dio.get('question');
    return response.data.map<Question>((json) => Question.fromJson(json)).toList();
  }

  Future<List<Question>> getQuestionsByUserId(int userId) async {
    final response = await _dio.get('question/user/$userId');
    return response.data.map<Question>((json) => Question.fromJson(json)).toList();
  }

  Future<Question> createQuestion(Question question) async {
    final response = await _dio.post('question', data: question.toJson());
    return Question.fromJson(response.data);
  }

  Future<List<Answer>> getAnswers(int questionId) async {
    final response = await _dio.get('question/$questionId/answers');
    return response.data.map<Answer>((json) => Answer.fromJson(json)).toList();
  }

  Future<Answer> createAnswer(Answer answer, int questionId) async {
    final response = await _dio.post('question/$questionId/answers', data: answer.toJson());
    return Answer.fromJson(response.data);
  }



}