import 'package:dio/dio.dart';
import 'package:ecoguardian/shared/infrastructure/helpers/storage_helper.dart';
import 'package:ecoguardian/shared/infrastructure/utils/serializable.dart';
import 'package:ecoguardian/shared/interface/it/locators/logger_locator.dart';
import 'package:logger/logger.dart';

import '../../../config/constants/constant.dart';

abstract class BaseService<TRequest extends Serializable> {
  final Dio _dio;
  final Logger logger = getIt<Logger>();
  final String token = "";
  final String resourcePath;
  get dio => _dio;

  BaseService({required this.resourcePath})
    : _dio = Dio(
        BaseOptions(
          baseUrl: Constant.baseUrl,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

  Future<String> getToken() async {
    return await StorageHelper.getToken() ?? "";
  }

Future<List<dynamic>> getAll() async {
  try {
    final token = await getToken();
    Options options = Options(headers: {'Authorization': 'Bearer $token'});
    final response = await _dio.get(
      Constant.baseUrl + resourcePath,
      options: options,
    );
    final List<dynamic> data = response.data;
    return data;
  } on DioException catch (e) {
    final statusCode = e.response?.statusCode;
    logger.log(
      Level.error,
      'Error while calling GET ${Constant.baseUrl}$resourcePath, status code: $statusCode, message: ${e.message}',
    );
    throw Exception('HTTP Error: $statusCode');
  } catch (e) {
    throw Exception("Unknown exception: $e");
  }
}


  Future<bool> post(TRequest request) async {
    try {
      final token = await getToken();
      Options options = Options(headers: {'Authorization': 'Bearer $token'});
      await _dio.post(
        Constant.baseUrl + resourcePath,
        data: request.toRequest(),
        options: options,
      );
      return true;
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      logger.log(
        Level.error,
        'Error while calling POST ${Constant.baseUrl}$resourcePath, status code: $statusCode, message: ${e.message}',
      );
      throw Exception('HTTP Error: $statusCode');
    } catch (e) {
      throw Exception("Unknown exception: $e");
    }
  }

  Future<bool> put(int id, TRequest request) async {
    try {
      final token = await getToken();
      Options options = Options(headers: {'Authorization': 'Bearer $token'});
      await _dio.put(
        "${Constant.baseUrl}$resourcePath/$id",
        data: request.toRequest(),
        options: options,
      );
      return true;
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      logger.log(
        Level.error,
        'Error while calling PUT ${Constant.baseUrl}$resourcePath, status code: $statusCode, message: ${e.message}',
      );
      throw Exception('HTTP Error: $statusCode');
    } catch (e) {
      throw Exception("Unknown exception: $e");
    }
  }

  Future<bool> delete(int id) async {
    try {
      final token = await getToken();
      Options options = Options(headers: {'Authorization': 'Bearer $token'});
      await _dio.delete(
        "${Constant.baseUrl}$resourcePath/$id",
        options: options,
      );
      return true;
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      logger.log(
        Level.error,
        'Error while calling DELETE ${Constant.baseUrl}$resourcePath, status code: $statusCode, message: ${e.message}',
      );
      throw Exception('HTTP Error: $statusCode');
    } catch (e) {
      throw Exception("Unknown exception: $e");
    }
  }

  Future<Map<String, dynamic>> getById(String id) async {
    try {
      final token = await getToken();
      Options options = Options(headers: {'Authorization': 'Bearer $token'});
      final response = await _dio.get(
        "${Constant.baseUrl}$resourcePath/$id",
        options: options,
      );
      final data = response.data;
      return data;
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      logger.log(
        Level.error,
        'Error while calling GET BY ID ${Constant.baseUrl}$resourcePath, status code: $statusCode, message: ${e.message}',
      );
      throw Exception('HTTP Error: $statusCode');
    } catch (e) {
      throw Exception("Unknown exception: $e");
    }
  }

  Future<Map<String, dynamic>> getByIdV2() async {
    try {
      final token = await getToken();
      Options options = Options(headers: {'Authorization': 'Bearer $token'});
      final response = await _dio.get(
        "${Constant.baseUrl}$resourcePath",
        options: options,
      );
      final data = response.data;
      return data;
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      logger.log(
        Level.error,
        'Error while calling GET BY ID ${Constant.baseUrl}$resourcePath, status code: $statusCode, message: ${e.message}',
      );
      throw Exception('HTTP Error: $statusCode');
    } catch (e) {
      throw Exception("Unknown exception: $e");
    }
  }

  Future<List<dynamic>> getV2() async {
    try{
      final token = await getToken();
      Options options = Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final response = await _dio.get("${Constant.baseUrl}$resourcePath", options: options);
      final List<dynamic> data = response.data;
      return data;
    } on DioException catch (e){
      final statusCode = e.response?.statusCode;
      logger.log(
        Level.error,
        'Error while calling GET BY ID ${Constant.baseUrl}$resourcePath, status code: $statusCode, message: ${e.message}',
      );
      throw Exception('HTTP Error: $statusCode');
    }catch (e){
      throw Exception("Unknown exception: $e");
    }
  }

  Future<List<dynamic>> getByParam() async {
    try {
      final token = await getToken();
      Options options = Options(headers: {'Authorization': 'Bearer $token'});
      final response = await _dio.get(
        "${Constant.baseUrl}$resourcePath",
        options: options,
      );
      final List<dynamic> data = response.data;
      return data;
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      logger.log(
        Level.error,
        'Error while calling GET BY ID ${Constant.baseUrl}$resourcePath, status code: $statusCode, message: ${e.message}',
      );
      throw Exception('HTTP Error: $statusCode');
    } catch (e) {
      throw Exception("Unknown exception: $e");
    }
  }

  Future<Map<String, dynamic>> getByParamObject() async {
    try {
      final token = await getToken();
      Options options = Options(headers: {'Authorization': 'Bearer $token'});

      final response = await _dio.get(
        "${Constant.baseUrl}$resourcePath",
        options: options,
      );

      // Asume que la respuesta siempre es Map
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      logger.log(
        Level.error,
        'Error while calling GET BY PARAM OBJECT ${Constant.baseUrl}$resourcePath, '
        'status code: $statusCode, message: ${e.message}',
      );
      throw Exception('HTTP Error: $statusCode');
    } catch (e) {
      throw Exception("Unknown exception: $e");
    }
  }
}
