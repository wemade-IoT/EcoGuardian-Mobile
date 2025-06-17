import 'package:dio/dio.dart';
import 'package:ecoguardian/shared/infrastructure/helpers/storage_helper.dart';
import 'package:ecoguardian/shared/infrastructure/utils/serializable.dart';
import 'package:ecoguardian/shared/interface/it/locators/logger_locator.dart';
import 'package:logger/logger.dart';

abstract class BaseService<TRequest extends Serializable, TResponse>{
  final Dio _dio;
  final Logger logger = getIt<Logger>();
  final String token ="";
  static const BASE_URL = "http://√:9080/api/v1/";
  final String resourcePath;
  final TResponse Function(Map<String, dynamic>) fromJson;

  BaseService(this.fromJson,{
    required this.resourcePath,
  }) : _dio = Dio(BaseOptions(
    baseUrl: BASE_URL,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  Future<String> getToken() async {
    return await StorageHelper.getToken() ?? "";
  }

  Future<List<TResponse>> getAll() async {
    try {
      final token = await getToken();
      Options options = Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final response = await _dio.get(BASE_URL + resourcePath, options: options);
      final data = response.data as List;
      return data.map((resource) => fromJson(resource)).toList();
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      logger.log(
        Level.error,
        'Error while calling GET $BASE_URL$resourcePath, status code: $statusCode, message: ${e.message}',
      );
      throw Exception('HTTP Error: $statusCode');
    } catch (e){
      throw Exception("Unknown exception: $e");
    }
  }

  Future<bool> post(TRequest request) async {
    try{
      final token = await getToken();
      Options options = Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      await _dio.post(BASE_URL + resourcePath, data: request.toRequest(), options: options);
      return true;
    } on DioException catch (e){
      final statusCode = e.response?.statusCode;
      logger.log(
        Level.error,
        'Error while calling POST $BASE_URL$resourcePath, status code: $statusCode, message: ${e.message}',
      );
      throw Exception('HTTP Error: $statusCode');
    }catch (e){
      throw Exception("Unknown exception: $e");
    }
  }

  Future<bool> put(int id, TRequest request) async {
    try{
      final token = await getToken();
      Options options = Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      await _dio.put("$BASE_URL$resourcePath/$id", data: request.toRequest(), options: options);
      return true;
    } on DioException catch (e){
      final statusCode = e.response?.statusCode;
      logger.log(
        Level.error,
        'Error while calling PUT $BASE_URL$resourcePath, status code: $statusCode, message: ${e.message}',
      );
      throw Exception('HTTP Error: $statusCode');
    }catch (e){
      throw Exception("Unknown exception: $e");
    }
  }

  Future<bool> delete(int id) async {
    try{
      final token = await getToken();
      Options options = Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      await _dio.delete("$BASE_URL$resourcePath/$id", options: options);
      return true;
    } on DioException catch (e){
      final statusCode = e.response?.statusCode;
      logger.log(
        Level.error,
        'Error while calling DELETE $BASE_URL$resourcePath, status code: $statusCode, message: ${e.message}',
      );
      throw Exception('HTTP Error: $statusCode');
    }catch (e){
      throw Exception("Unknown exception: $e");
    }
  }

  Future<TResponse> getById(int id) async {
    try{
      final token = await getToken();
      Options options = Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final response = await _dio.get("$BASE_URL$resourcePath/$id", options: options);
      final data = response.data;
      return data;
    } on DioException catch (e){
      final statusCode = e.response?.statusCode;
      logger.log(
        Level.error,
        'Error while calling GET BY ID $BASE_URL$resourcePath, status code: $statusCode, message: ${e.message}',
      );
      throw Exception('HTTP Error: $statusCode');
    }catch (e){
      throw Exception("Unknown exception: $e");
    }
  }

}