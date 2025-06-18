import 'dart:convert';

import 'package:ecoguardian/iam/domain/dto/sign_in_request.dto.dart';
import 'package:ecoguardian/iam/domain/dto/user_authenticated_response.dto.dart';
import 'package:ecoguardian/iam/infrastructure/services/auth.service.dart';
import 'package:ecoguardian/shared/infrastructure/helpers/storage_helper.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier{

  Map<String, dynamic> allowRoles = {
     "Enterpise": true,
    "Domestic": false,
    "Admin": true,
  };

  Future<void> signIn(String email, String password)async {
    final SignInRequestDto request = SignInRequestDto(email: email, password: password);
    final authService = AuthService();
    final response = await authService.signIn(request);
    final AuthenticatedResponseDto authenticatedResponseDto = AuthenticatedResponseDto.fromJson(response);
    await StorageHelper.saveToken(authenticatedResponseDto.token);
    await StorageHelper.saveUserId(authenticatedResponseDto.id);

  }

  Future<Map<String,dynamic>> getPayload() async{
    final token = await StorageHelper.getToken();
    final parts = token!.split('.');
    if (parts.length != 3) {
      throw Exception('Token inválido');
    }
    final payload = parts[1];
    final normalized = base64.normalize(payload);
    final payloadMap = json.decode(utf8.decode(base64Url.decode(normalized)));
    return payloadMap;
  }

  Future<bool> isEnterprise() async{
    final payload = await getPayload();
    final role = payload["http://schemas.microsoft.com/ws/2008/06/identity/claims/role"];
    print(role);
    return allowRoles[role];
  }




}