
class SignInRequestDto{
  final String email;
  final String password;

  SignInRequestDto({
    required this.email,
    required this.password
 });

  Map<String,dynamic> toRequest(){
      return {
        "email": email,
        "password": password
      };
  }

}