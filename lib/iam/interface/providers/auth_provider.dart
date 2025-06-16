import 'package:ecoguardian/iam/domain/dto/sign_in_request.dto.dart';
import 'package:ecoguardian/iam/infrastructure/services/auth.service.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier{

  Future<Map<String,dynamic>> signIn(String email, String password){
    final SignInRequestDto request = SignInRequestDto(email: email, password: password);
    final authService = AuthService();
    final response = authService.signIn(request);
    return response;
  }


}