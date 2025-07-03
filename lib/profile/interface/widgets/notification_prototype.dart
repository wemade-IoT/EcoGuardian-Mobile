import 'package:ecoguardian/profile/domain/dto/notification.dto.dart';
import 'package:ecoguardian/shared/infrastructure/helpers/date_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/web.dart';

class NotificationPrototype extends StatelessWidget {
  final NotificationDto notificationDto;
  const NotificationPrototype({super.key, required this.notificationDto});

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(notificationDto.createdAt!);
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            width: 1,
            color: Colors.grey
          )
        ),
        title: Text(notificationDto.title!),
        subtitle: Row(
          children: [
            Text("Registered at "),
            Text(formatDate(date))
          ],
        ),
      ),
    );
  }
}
