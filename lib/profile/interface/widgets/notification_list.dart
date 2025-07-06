import 'package:ecoguardian/profile/interface/providers/notification_provider.dart';
import 'package:ecoguardian/profile/interface/widgets/notification_prototype.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationProvider = context.watch<NotificationProvider>();

    if (notificationProvider.notificationsCount == 0) {
      return const Center(
          child: Text(
              "No notifications available",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          )
      );
    }

    return ListView.builder(
      itemCount: notificationProvider.notificationsCount,
      itemBuilder: (BuildContext context, int index) {
        return NotificationPrototype(
          notificationDto: notificationProvider.notifications[index],
        );
      },
    );
  }
}
