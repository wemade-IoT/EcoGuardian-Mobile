import 'package:ecoguardian/crm/domain/dto/answer.dto.dart';
import 'package:ecoguardian/crm/interface/providers/answer_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'answer_card.dart';

class AnswerList extends StatefulWidget {
  final List<AnswerDto> answers;
  const AnswerList({super.key, required this.answers});

  @override
  State<AnswerList> createState() => _AnswerListState();
  
}

class _AnswerListState extends State<AnswerList> {
  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount:widget.answers.length,
          itemBuilder: (BuildContext context, int index){
            return AnswerCard(
                  answerDto:
                 widget.answers[index]
            );
          }
      ),
    );
  }
}
