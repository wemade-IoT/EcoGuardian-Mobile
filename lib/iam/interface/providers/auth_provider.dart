import 'dart:convert';

import 'package:ecoguardian/iam/domain/dto/sign_in_request.dto.dart';
import 'package:ecoguardian/iam/domain/dto/user_authenticated_response.dto.dart';
import 'package:ecoguardian/iam/infrastructure/services/auth.service.dart';
import 'package:ecoguardian/shared/infrastructure/helpers/storage_helper.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier{

  Future<void> signIn(String email, String password)async {
    final SignInRequestDto request = SignInRequestDto(email: email, password: password);
    final authService = AuthService();
    final response = await authService.signIn(request);
    final AuthenticatedResponseDto authenticatedResponseDto = AuthenticatedResponseDto.fromJson(response);
    await StorageHelper.saveToken(authenticatedResponseDto.token);
    await StorageHelper.saveUserId(authenticatedResponseDto.id);

  }




}