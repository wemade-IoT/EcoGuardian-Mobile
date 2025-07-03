import 'package:ecoguardian/crm/domain/dto/question.dto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final QuestionDto questionDto;
  const QuestionCard({super.key, required this.questionDto});

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
        title: Text("${questionDto.title!}# ${questionDto.questionId}"),
        subtitle: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(questionDto.content!),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Status"),
                Text(questionDto.status!)
              ],
            )
          ],
        ),
      ),
    );
  }
}
