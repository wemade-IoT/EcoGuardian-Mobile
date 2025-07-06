import 'package:ecoguardian/crm/interface/screens/answers_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ecoguardian/public/interface/widgets/custom_elevated_button.dart';
import 'package:ecoguardian/public/interface/widgets/custom_text_field.dart';
import 'package:ecoguardian/shared/infrastructure/helpers/storage_helper.dart';

import '../../../config/theme/app_theme.dart';
import '../../../public/interface/widgets/custom_dialog.dart';
import '../providers/answer_provider.dart';

class AnswerDialog extends StatefulWidget {
  final int questionId;
  const AnswerDialog({super.key, required this.questionId});

  @override
  _AnswerDialogState createState() => _AnswerDialogState();
}

class _AnswerDialogState extends State<AnswerDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController answerTextController;

  @override
  void initState() {
    super.initState();
    answerTextController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    answerTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final answerProvider = context.watch<AnswerProvider>();

    return SingleChildScrollView(
      child: AlertDialog(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Text(
              "Submit Answer",
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: answerTextController,
                    hintText: "Enter your answer",
                    label: "Answer",
                    onValidate: (_) {
                      return null; // No validation needed
                    },
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final specialistId = await StorageHelper.getUserId();
                          final answerText = answerTextController.text;
                          try {
                            await answerProvider.createAnswer(specialistId!, answerText, widget.questionId);
                            Navigator.pop(context);
                            context.go("/consulting");
                          } catch (e) {
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialog(
                                  title: "An error has occurred",
                                  content: "An error occurred while submitting the answer. Please try again.",
                                  isSuccess: false,
                                  onConfirm: () {},
                                  onCancel: () {},
                                );
                              },
                            );
                          }
                        }
                      },
                      background: CustomColors.primary,
                      foreground: Colors.white,
                      label: "Submit",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
