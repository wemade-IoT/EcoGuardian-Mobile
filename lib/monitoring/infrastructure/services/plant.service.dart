import 'package:dio/dio.dart';
import 'package:ecoguardian/monitoring/domain/dto/plant.dto.dart';
import 'package:ecoguardian/shared/infrastructure/services/base_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

import '../../../config/constants/constant.dart';

class PlantService extends BaseService{
  PlantService({required super.resourcePath});




  Future<void> createPlant(PlantDto request) async {
    try {
      final token = await getToken();

      final formData = FormData();
      final Map<String, dynamic> requestData = request.toRequest();
      requestData.forEach((key, value) {
        if (value is XFile) {
          formData.files.add(MapEntry(
            key,
            MultipartFile.fromFileSync(value.path, filename: "$key.jpg"),
          ));
        } else if (value is List<int>) {
          formData.files.add(MapEntry(
            key,
            MultipartFile.fromBytes(value, filename: "$key.jpg"),
          ));
        } else if (value is MultipartFile) {
          formData.files.add(MapEntry(key, value));
        } else {
          formData.fields.add(MapEntry(key, value.toString()));
        }
      });

      final options = Options(
        headers: {
          'Content-Type': 'multipart/form-data',
          'Authorization': 'Bearer $token',
        },
      );

      await dio.post(
        Constant.baseUrl + resourcePath,
        data: formData,
        options: options,
      );
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




  Future<List<PlantDto>> getPlantsByUserId(int userId) async {
    try {
      final token = await getToken();
      Options options = Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final response = await dio.get(
        Constant.baseUrl + resourcePath + "?userId=" + userId.toString(),
        options: options,
      );
      final List<dynamic> plants = response.data;
      return plants.map((resource) => PlantDto.fromJson(resource)).toList();
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


}