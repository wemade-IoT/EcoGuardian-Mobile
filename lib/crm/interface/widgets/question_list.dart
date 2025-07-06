import 'package:ecoguardian/crm/interface/providers/question_provider.dart';
import 'package:ecoguardian/crm/interface/screens/answers_screen.dart';
import 'package:ecoguardian/crm/interface/widgets/answer_form.dart';
import 'package:ecoguardian/crm/interface/widgets/question_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class QuestionList extends StatelessWidget {
  const QuestionList({super.key});

  @override
  Widget build(BuildContext context) {
    final questionProvider = context.watch<QuestionProvider>();
    return  ListView.builder(
          shrinkWrap: true,
          itemCount: questionProvider.questionCount,
          itemBuilder: (BuildContext context, int index){
            return  GestureDetector(
              onTap: (){
                context.go("/answer",extra: questionProvider.questions[index].questionId );
              },
                child: QuestionCard(
                  questionDto:
                  questionProvider.questions[index]
                            ),
              );
          }
    );
  }
}
