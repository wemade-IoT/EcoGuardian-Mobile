import 'package:ecoguardian/shared/infrastructure/utils/serializable.dart';

class SignUpRequestDto{
  final String email;
  final String password;
  final int roleId;

  SignUpRequestDto({
    required this.email,
    required this.password,
    required this.roleId
  });

  Map<String,dynamic> toRequest(){
    return {
      "email": email,
      "password": password,
      "role_id": roleId
    };
  }



}