import 'package:ecoguardian/config/theme/app_theme.dart';
import 'package:ecoguardian/crm/interface/providers/answer_provider.dart';
import 'package:ecoguardian/crm/interface/widgets/answer_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/answer_form.dart';

class MyAnswersScreen extends StatelessWidget {
  const MyAnswersScreen({super.key});

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
                    'My Answers Screen',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  AnswerList(
                     answers: answerProvider.answers,
                  ),
                  const SizedBox(height: 80)
                ]
            ),
          )
      ),
    );
  }
}

