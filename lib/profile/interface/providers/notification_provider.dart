import 'package:ecoguardian/profile/domain/dto/notification.dto.dart';
import 'package:ecoguardian/profile/infrastructure/services/notification_service.dart';
import 'package:ecoguardian/shared/infrastructure/helpers/storage_helper.dart';
import 'package:flutter/cupertino.dart';

class NotificationProvider extends ChangeNotifier{

  List<NotificationDto> _notifications = [];
  get notifications => _notifications;
  get notificationsCount => _notifications.length;

  Future<void> getNotificationsByUserId() async{
    try{
      final userId = await StorageHelper.getUserId();
      final notificationService = NotificationService(resourcePath: "notifications?profileId=$userId");
      _notifications = await notificationService.getNotificationsByUserId(userId!);

      print(_notifications);

      notifyListeners();
    } catch (e){
  throw Exception("No notifications available");
    }
  }

}