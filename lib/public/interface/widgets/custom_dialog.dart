import 'package:ecoguardian/public/interface/widgets/custom_elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config/theme/app_theme.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final bool isSuccess;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  const CustomDialog({super.key, required this.title, required this.content, required this.isSuccess, required this.onConfirm, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Column(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isSuccess ? Image.network(
              "https://tse4.mm.bing.net/th?id=OIP.n14Ol6TVmnrRsqREKz5rTwHaHa&pid=Api&P=0&h=180",
            width: 100,
          )
              : Image.network(
              "https://cdn0.iconfinder.com/data/icons/shift-interfaces/32/Error-1024.png",
            width: 100,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.black
            ),
          ),
          Text(
              content,
            style: TextStyle(
              fontSize: 15.0,
              color: isSuccess ? CustomColors.darkGreen : Colors.red
            ),
          )
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        CustomElevatedButton(
            onPressed: onCancel,
            background: CustomColors.lightGrey,
            foreground:  Colors.black,
            label: "Cancel"
        ),
        CustomElevatedButton(
            onPressed: onConfirm,
            background: CustomColors.darkGreen,
            foreground: Colors.white,
            label: "Confirm"
        )
      ],

    );
  }
}
