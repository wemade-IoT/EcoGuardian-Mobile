import 'dart:io';

import 'package:ecoguardian/crm/interface/providers/question_provider.dart';
import 'package:ecoguardian/crm/interface/widgets/question_list.dart';
import 'package:ecoguardian/iam/interface/providers/auth_provider.dart';
import 'package:ecoguardian/monitoring/interface/providers/plant_provider.dart';
import 'package:ecoguardian/public/interface/widgets/custom_elevated_button.dart';
import 'package:ecoguardian/shared/infrastructure/helpers/storage_helper.dart';
import 'package:ecoguardian/shared/interface/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../config/theme/app_theme.dart';
import '../providers/answer_provider.dart';
import '../widgets/consumer_widget.dart';
import '../widgets/question_dialog.dart';

class ConsultingScreen extends StatefulWidget {

  static const String name = 'consulting_screen';

  const ConsultingScreen({super.key});

  @override
  State<ConsultingScreen> createState() => _ConsultingScreenState();
}

class _ConsultingScreenState extends State<ConsultingScreen> {
  var user = StorageHelper.getUser();
  var name = 'Consulting Screen';
  int selectedPlant = 0;
  bool isSpecialist = false;
  bool isEnterprise = false;



  void _showQuestionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return QuestionDialog(
          selectedPlant: selectedPlant,
          role: isEnterprise ? "enterprise" : "domestic",
        );
      },
    );
  }




  @override
  void initState(){
    super.initState();
    final authProvider = context.read<AuthProvider>();
    ()async{
      isSpecialist = await authProvider.isSpecialist();
      isEnterprise = await authProvider.isEnterprise() || await authProvider.isAdmin();
      final userId = await StorageHelper.getUserId();
      if(isSpecialist){
        Future.microtask(() => Provider.of<QuestionProvider>(context, listen: false).getQuestions());
        Future.microtask(() => Provider.of<AnswerProvider>(context, listen: false).getAnswersBySpecialistId(userId!));
      }
    }();
  }





  @override

  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    children: [
                      const Text(
                        'Consulting Screen',
                        style: TextStyle(fontSize: 24),
                      ),
                      const SizedBox(height: 20),
                     // _consumerWidget("domestic", context)
                     isSpecialist ? _specialistWidget() : _consumerWidget(isEnterprise ? 'business' : 'domestic', context)
                    ]
                  ),
                ),
        )
        );
  }

  Widget _consumerWidget(String role, BuildContext context) {
    final plantProvider = context.watch<PlantProvider>();
    final questionProvider = context.watch<QuestionProvider>();
    return Column(
      spacing: 20,
      children: [
        CustomDropdown(
            options: plantProvider.plants,
          initialValue: selectedPlant,
          onChanged: (value){
              setState(() {
                selectedPlant = value!;
              });
              questionProvider.getQuestionsByPlantId(selectedPlant);
          },
        ),
        selectedPlant > 0 ?
        QuestionList() :
        Container(),
        selectedPlant > 0 ?
            CustomElevatedButton(
                onPressed: () {
                  _showQuestionDialog(context);
                },
                background: CustomColors.primary,
                foreground: CustomColors.white,
                label: "Create a question"
            ) : Container(),
        SizedBox(height: 70)

      ],
    );
  }
  Widget _specialistWidget() {
    return Column(
      children: [
        Text('Specialist Menu', style: TextStyle(fontSize: 20)),
        const SizedBox(height: 20),
        QuestionList()
      ],
    );
  }
}

