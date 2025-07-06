import 'package:ecoguardian/crm/interface/providers/answer_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'answer_card.dart';

class AnswerList extends StatefulWidget {
  final int questionId;
  const AnswerList({super.key, required this.questionId});

  @override
  State<AnswerList> createState() => _AnswerListState();
  
}

class _AnswerListState extends State<AnswerList> {
  @override
  void initState(){
    super.initState();
    Future.microtask(() => Provider.of<AnswerProvider>(context, listen: false).getAnswersByQuestionId(widget.questionId));
  }
  @override
  Widget build(BuildContext context) {
    final answerProvider = context.watch<AnswerProvider>();
    return  Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: answerProvider.answersCount,
          itemBuilder: (BuildContext context, int index){
            return AnswerCard(
                  answerDto:
                 answerProvider.answers[index]!
            );
          }
      ),
    );
  }
}
