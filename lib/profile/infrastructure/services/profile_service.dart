import 'package:ecoguardian/profile/domain/dto/profile.dto.dart';
import 'package:ecoguardian/shared/infrastructure/services/base_service.dart';
import 'package:logger/logger.dart';

class ProfileService extends BaseService {
  ProfileService({required super.resourcePath});

  Future<ProfileDto> getProfileByEmail(String email) async {
    try {
      final response = await getByParamObject();
      if (response.isEmpty) {
        throw Exception("No profile found for email $email");
      }
      print(response);
      return ProfileDto.fromJson(response);
    } catch (e) {
      logger.log(Level.error, "An error has occurred while trying to fetch profile: $e");
      throw Exception("Error fetching profile: $e");
    }
  }

}