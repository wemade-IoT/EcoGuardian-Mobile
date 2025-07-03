import 'package:ecoguardian/profile/domain/dto/notification.dto.dart';
import 'package:ecoguardian/shared/infrastructure/services/base_service.dart';
import 'package:logger/logger.dart';

class NotificationService extends BaseService {
  NotificationService({required super.resourcePath});

  Future<List<NotificationDto>> getNotificationsByUserId(int userId) async{
    try{
      final  response = await getByParam();
      final notifications = response.map((json) => NotificationDto.fromJson(json)).toList();
      print(notifications.length);
      return notifications;
    } catch (e){
      logger.log(Level.error, "An error has ocurred while trying to fetch notifications $e");
      throw Exception("An error has ocurred while trying $e");
    }
  }

}