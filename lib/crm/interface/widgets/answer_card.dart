import 'package:ecoguardian/crm/domain/dto/answer.dto.dart';
import 'package:ecoguardian/crm/domain/dto/question.dto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/infrastructure/helpers/date_helper.dart';

class AnswerCard extends StatelessWidget {
  final AnswerDto answerDto;
  const AnswerCard({super.key, required this.answerDto});

  @override
  Widget build(BuildContext context) {
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
        title: Text("${answerDto.questionTitle!}# ${answerDto.id}"),
        subtitle: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(answerDto.answerText!),
            Row(
              children: [
                Text("Registered at "),
                Text(formatDate(answerDto.createdAt!))
              ],
            )
          ],
        ),
      ),
    );
  }
}
