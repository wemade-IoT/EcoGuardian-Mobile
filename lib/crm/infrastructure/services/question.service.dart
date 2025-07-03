import 'package:dio/dio.dart';
import 'package:ecoguardian/crm/domain/dto/question.dto.dart';
import 'package:ecoguardian/shared/infrastructure/services/base_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

import '../../../config/constants/constant.dart';

class QuestionService extends BaseService<QuestionDto>{
  QuestionService({required super.resourcePath});

  Future<void> createQuestion(QuestionDto request) async {
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


}