import 'package:ecoguardian/crm/domain/dto/question.dto.dart';
import 'package:ecoguardian/crm/infrastructure/services/question.service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class QuestionProvider extends ChangeNotifier{
  List<QuestionDto> questions = [];
  get questionCount => questions.length;

  Future<void> createQuestion(String title,String content,int plantId,int userId, List<XFile> imageUrls) async{
    try{
      final request = QuestionDto(
          title: title,
          content: content,
          plantId: plantId,
          userId: userId
      );
      final questionService = QuestionService(resourcePath: "questions");
      await questionService.createQuestion(request);
      notifyListeners();
    } catch (e){
      throw Exception("An error has ocurred while trying to create question $e");
    }
  }

  Future<void> getQuestionsByPlantId(int plantId) async {
    questions = [];
    try{
      final questionService = QuestionService(resourcePath: "questions/plant/${plantId.toString()}");
      final response = await questionService.getV2();
      questions =response.map((json) => QuestionDto.fromJson(json)).toList();
      notifyListeners();
    }catch (e){
      questions = [];
      throw Exception("An error has ocurred while trying to fetch question by plant id ${plantId.toString()} $e");
    }
  }

  Future<void> getQuestions() async {
    questions = [];
    try{
      final questionService = QuestionService(resourcePath: "questions");
      final response = await questionService.getAll();
      questions =response.map((json) => QuestionDto.fromJson(json)).toList();
      notifyListeners();
    }catch (e){
      questions = [];
      throw Exception("An error has ocurred while trying to fetch questions available $e");
    }
  }

}