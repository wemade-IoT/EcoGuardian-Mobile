import 'package:dio/dio.dart';
import 'package:ecoguardian/config/constants/constant.dart';
import 'package:ecoguardian/planning/domain/dto/device.dto.dart';
import 'package:ecoguardian/shared/infrastructure/services/base_service.dart';
import 'package:logger/web.dart';

class DeviceService extends BaseService {
  DeviceService({required super.resourcePath});

  Future<Map<String, dynamic>> createDevice(DeviceDto request) async {
    try {
      final token = await getToken();

      final Map<String, dynamic> requestData = request.toRequest();
      print("Request data: $requestData");

      final options = Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final response =await dio.post(
        Constant.baseUrl + resourcePath,
        data: requestData,
        options: options,
      );

      return {'message': response.data['message'], 'id': response.data['id']};
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      logger.log(
        Level.error,
        'Error while calling POST ${Constant.baseUrl}$resourcePath, status code: $statusCode, message: ${e.message}',
      );
      throw Exception('HTTP Error: $statusCode');
    } catch (e) {
      throw Exception("An error occurred while registering the device: $e");
    }
  }

  Future<List<DeviceDto>> getDevicesByPlantId(int plantId) async {
    try {
      final token = await getToken();
      Options options = Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final response = await dio.get(
        Constant.baseUrl + resourcePath + "?plantId=" + plantId.toString(),
        options: options,
      );

      final List<dynamic> data = response.data;
      return data.map((item) => DeviceDto.fromJson(item)).toList();
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      logger.log(
        Level.error,
        'Error while calling GET ${Constant.baseUrl}$resourcePath/plant/$plantId, status code: $statusCode, message: ${e.message}',
      );
      throw Exception('HTTP Error: $statusCode');
    } catch (e) {
      throw Exception("An error occurred while fetching devices: $e");
    }
  }
}
