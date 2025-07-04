import 'package:ecoguardian/crm/domain/dto/answer.dto.dart';
import 'package:ecoguardian/crm/infrastructure/services/answer.service.dart';
import 'package:flutter/material.dart';

class AnswerProvider extends ChangeNotifier{
  List<AnswerDto> _answers = [];
  get answers => _answers;
  get answersCount => _answers.length;

  Future<void> createAnswer(int specialistId, String answerText, int questionId) async{
    try{
      final request = AnswerDto(
          specialistId: specialistId,
          answerText: answerText
      );
      final answerService = AnswerService(resourcePath: "questions/${questionId.toString()}/answers");
      await answerService.post(request);
    } catch (e){
      throw Exception("An error has ocurred while trying to create a answer $e");
    }
  }

  Future<void> getAnswersByQuestionId(int questionId) async {
    try{
      final answerService = AnswerService(resourcePath: "questions/${questionId.toString()}/answers");
      final response = await answerService.getV2();
      _answers = response.map((json) => AnswerDto.fromJson(json)).toList();
      notifyListeners();
    } catch (e){
      throw Exception("An error has ocurred while trying to create a answer $e");
    }
  }
}