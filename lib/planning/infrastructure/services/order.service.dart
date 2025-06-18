import 'package:dio/dio.dart';
import 'package:ecoguardian/planning/domain/dto/order_request.dto.dart';
import 'package:logger/logger.dart';
import '../../../shared/interface/it/locators/logger_locator.dart';

class OrderService {
  final Dio _dio;
  final Logger logger = getIt<Logger>();
  static const BASE_URL = "http://10.0.2.2:9080/api/v1/";

  OrderService() : _dio = Dio(BaseOptions(
    baseUrl: BASE_URL,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  Future<void> createOrder(OrderRequestDto request) async {
    try {
      await _dio.post("order", data: request.toJson());
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      logger.log(
        Level.error,
        'Error while calling POST "+BASE_URL+order, status code: $statusCode, message: ${e.message}',
      );
      throw Exception('HTTP Error: $statusCode');
    } catch (e) {
      throw Exception("Unknown exception: $e");
    }
  }
}

