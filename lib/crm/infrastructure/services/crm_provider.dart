import 'package:ecoguardian/crm/infrastructure/services/crm_service.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/models/answer.dart';
import '../../domain/models/question.dart';

class QuestionViewModel extends ChangeNotifier {
  final CRMService _crmService = CRMService();

  List<Question> _questions = [];

  List<Question> get questions => _questions;

  Question? _createdQuestion;

  Question? get createdQuestion => _createdQuestion;

  List<Question> _userQuestions = [];
  List<Question> get userQuestions => _userQuestions;

  List<Question> _allQuestions = [];

  List<Question> get allQuestions => _allQuestions;

  Answer? _createdAnswer;
  Answer? get createdAnswer => _createdAnswer;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  // --- Funciones para el rol Usuario ---
  Future<void> fetchUserQuestions(int userId) async {
    _setLoading(true);
    _setError(null);
    try {
      _userQuestions = await _crmService.getQuestionsByUserId(userId);
    } catch (e) {
      print('Error fetching user questions: $e');
      _setError('Failed to load your questions. Please try again.');
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> submitQuestion(Question question) async {
    _setLoading(true);
    _setError(null);
    try {
      _createdQuestion = await _crmService.createQuestion(question);
      // Opcional: Refrescar la lista de preguntas del usuario
      // await fetchUserQuestions(someUserId); // Necesitarías el ID del usuario aquí
      _setLoading(false);
      return true;
    } catch (e) {
      print('Error submitting question: $e');
      _setError('Failed to submit your question. Please try again.');
      _setLoading(false);
      return false;
    }
  }

  // --- Funciones para el rol Especialista ---
  Future<void> fetchAllQuestionsForSpecialist() async {
    _setLoading(true);
    _setError(null);
    try {
      _allQuestions = await _crmService.getQuestions();
    } catch (e) {
      print('Error fetching all questions: $e');
      _setError('Failed to load questions. Please try again.');
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> submitAnswer(Answer answer, int questionId) async {
    _setLoading(true);
    _setError(null);
    try {
      _createdAnswer = await _crmService.createAnswer(answer, questionId);
      await fetchAllQuestionsForSpecialist();
      _setLoading(false);
      return true;
    } catch (e) {
      print('Error submitting answer: $e');
      _setError('Failed to submit answer. Please try again.');
      _setLoading(false);
      return false;
    }
  }
}