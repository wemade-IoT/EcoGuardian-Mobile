import 'package:dio/dio.dart';
import 'package:ecoguardian/iam/domain/dto/sign_in_request.dto.dart';
import 'package:logger/logger.dart';

import '../../../config/constants/constant.dart';
import '../../../shared/interface/it/locators/logger_locator.dart';

class AuthService {
  final Dio _dio;
  final Logger logger = getIt<Logger>();

  AuthService() : _dio = Dio(BaseOptions(
    baseUrl: Constant.baseUrl,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  Future<Map<String,dynamic>> signIn(SignInRequestDto request) async{
    try{
      final response = await _dio.post("${Constant.baseUrl}authentication/sign-in", data:  request.toRequest());
      return response.data;
    } on DioException catch(e){
      final statusCode = e.response?.statusCode;
      logger.log(
        Level.error,
        'Error while calling POST ${Constant.baseUrl}authentication/sign-in, status code: $statusCode, message: ${e.message}',
      );
      throw Exception('HTTP Error: $statusCode');
    } catch (e){
      throw Exception("Unknown exception: $e");
    };
  }

}