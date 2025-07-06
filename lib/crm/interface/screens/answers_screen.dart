import 'package:ecoguardian/config/theme/app_theme.dart';
import 'package:ecoguardian/crm/interface/providers/answer_provider.dart';
import 'package:ecoguardian/crm/interface/widgets/answer_list.dart';
import 'package:ecoguardian/public/interface/widgets/custom_elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/answer_form.dart';

class AnswersScreen extends StatefulWidget {
  final int? questionId;
  const AnswersScreen({super.key, this.questionId});
  
  @override
  State<AnswersScreen> createState() => _AnswersScreenState();
  
}

class _AnswersScreenState extends State<AnswersScreen> {
  @override
  void initState(){
    super.initState();
    Future.microtask(() => Provider.of<AnswerProvider>(context, listen: false).getAnswersByQuestionId(widget.questionId!));
  }

  @override
  Widget build(BuildContext context) {
    final answerProvider = context.watch<AnswerProvider>();
    return Scaffold(
        body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Expanded(
                child: Column(
                    children: [
                      const Text(
                        'Answers Screen',
                        style: TextStyle(fontSize: 24),
                      ),
                      const SizedBox(height: 20),
                     AnswerList(
                       answers: answerProvider.answers,
                     ),
                      CustomElevatedButton(
                          onPressed: ()async{
                            await showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AnswerDialog(questionId: widget.questionId! );
                              }
                            );

                          },
                          background: CustomColors.primary,
                          foreground: CustomColors.white,
                          label: "Submit answer"
                      ),
                      const SizedBox(height: 80)
                    ]
                ),
              )
          ),
    );
  }
}

