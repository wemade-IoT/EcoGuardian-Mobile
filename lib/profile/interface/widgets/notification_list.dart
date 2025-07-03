import 'package:ecoguardian/profile/interface/providers/notification_provider.dart';
import 'package:ecoguardian/profile/interface/widgets/notification_prototype.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationProvider = context.watch<NotificationProvider>();
    return ListView.builder(
        itemCount: notificationProvider.notificationsCount,
        itemBuilder: (BuildContext context, int index){
          return NotificationPrototype(
              notificationDto:notificationProvider.notifications[index]
          );
        }
    );
  }
}
