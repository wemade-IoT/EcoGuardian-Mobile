import 'package:ecoguardian/crm/interface/providers/answer_provider.dart';
import 'package:ecoguardian/crm/interface/widgets/answer_list.dart';
import 'package:ecoguardian/crm/interface/widgets/question_card.dart';
import 'package:ecoguardian/crm/interface/widgets/question_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnswersScreen extends StatefulWidget {
  final int questionId;
  const AnswersScreen({super.key, required this.questionId});
  
  @override
  State<AnswersScreen> createState() => _AnswersScreenState();
  
}

class _AnswersScreenState extends State<AnswersScreen> {
  @override
  void initState(){
    super.initState();
    Future.microtask(() => Provider.of<AnswerProvider>(context, listen: false).getAnswersByQuestionId(widget.questionId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Expanded(
                child: Column(
                    children: [
                      const Text(
                        'Answers Screen',
                        style: TextStyle(fontSize: 24),
                      ),
                      const SizedBox(height: 20),
                     AnswerList(questionId: widget.questionId)
                    ]
                ),
              )
          ),
        )
    );
  }
}

