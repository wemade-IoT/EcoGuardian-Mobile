class AuthenticatedResponseDto {
  final int id;
  final String email;
  final String token;

  AuthenticatedResponseDto.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'],
        token = json['token'];

}
