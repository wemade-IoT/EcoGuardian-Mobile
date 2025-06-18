import 'package:dio/dio.dart';
import 'package:ecoguardian/monitoring/domain/dto/plant.dto.dart';
import 'package:ecoguardian/shared/infrastructure/services/base_service.dart';
import 'package:logger/logger.dart';

class PlantService extends BaseService{
  PlantService({required super.resourcePath});

  Future<List<PlantDto>> getPlantsByUserId(int userId) async {
    try {
      final token = await getToken();
      Options options = Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final response = await dio.get(
        BASE_URL + resourcePath + "?userId=" + userId.toString(),
        options: options,
      );
      final List<dynamic> plants = response.data;
      return plants.map((resource) => PlantDto.fromJson(resource)).toList();
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      logger.log(
        Level.error,
        'Error while calling GET $BASE_URL$resourcePath, status code: $statusCode, message: ${e.message}',
      );
      throw Exception('HTTP Error: $statusCode');
    } catch (e) {
      throw Exception("Unknown exception: $e");
    }
  }


}