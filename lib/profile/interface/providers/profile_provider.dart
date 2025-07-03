import 'package:ecoguardian/profile/domain/dto/profile.dto.dart';
import 'package:ecoguardian/profile/infrastructure/services/profile_service.dart';
import 'package:ecoguardian/shared/infrastructure/helpers/storage_helper.dart';
import 'package:flutter/cupertino.dart';

class ProfileProvider extends ChangeNotifier{
  ProfileDto? _profile;
  get profile => _profile;

  Future<void> getProfileByEmail() async{
     try{
       final email = await StorageHelper.getEmail();
       final profileService = ProfileService(resourcePath: "profiles");
       final response = await profileService.getById(email!);
       print(response);
       _profile = ProfileDto.fromJson(response);
       notifyListeners();
     } catch (e){
       throw Exception("No profile available $e");
     }
  }
}