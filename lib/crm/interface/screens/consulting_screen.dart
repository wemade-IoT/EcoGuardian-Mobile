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
import '../widgets/consumer_widget.dart';

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
  List<XFile>? selectedImages;
  bool isSpecialist = false;
  bool isEnterprise = false;



  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();


  @override
  void initState(){
    super.initState();
    final authProvider = context.read<AuthProvider>();
    ()async{
      isSpecialist = await authProvider.isSpecialist();
      isEnterprise = await authProvider.isEnterprise() || await authProvider.isAdmin();
      if(isSpecialist){
        Future.microtask(() => Provider.of<QuestionProvider>(context, listen: false).getQuestions());
      }
    }();
  }

  @override
  void dispose(){
    super.dispose();
    _questionController.dispose();
    _titleController.dispose();
  }


  Future<void> pickImagesFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> pickedFileList = await picker.pickMultiImage(
      maxWidth: 400,
      maxHeight: 500,
      imageQuality: 100,
    );
    setState(() {
      selectedImages = pickedFileList;
    });
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
                      'Consulting Screen',
                      style: TextStyle(fontSize: 24),
                    ),
                    const SizedBox(height: 20),
                   // _consumerWidget("domestic", context)
                   isSpecialist ? _specialistWidget() : _consumerWidget(isEnterprise ? 'business' : 'domestic', context)
                  ]
                ),
              )
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
        selectedPlant > 0 ?  TextField(
          controller: _titleController,
          decoration: InputDecoration(
            labelText: 'Titulo de la pregunta',
            border: OutlineInputBorder(),
          ),
        ) : Container(),
       selectedPlant > 0 ?  TextField(
         controller: _questionController,
         decoration: InputDecoration(
           labelText: role == 'domestic' ?'Preguntas de tus plantas' : 'Preguntas de tus plantaciones',
           border: OutlineInputBorder(),
         ),
       ) : Container(),

        selectedPlant > 0 ? GestureDetector(
            onTap: pickImagesFromGallery,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[200],
              ),
              child: Center(
                child: selectedImages == null
                    ? Icon(
                  Icons.add_a_photo,
                  color: Colors.grey[700],
                  size: 50,
                )
                    : ListView.builder(
                     itemCount: selectedImages!.length,
                     itemBuilder: (BuildContext context, int index){
                        return ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                            File( selectedImages![index].path),
                            fit: BoxFit.cover,
                        ),
                       );
                     }
                   )
                )
              ),
            )
            : Container(),

        selectedPlant > 0 ? CustomElevatedButton(
            onPressed: () async{
              final userId = await StorageHelper.getUserId();
              questionProvider.createQuestion(
                  _titleController.text,
                  _questionController.text,
                  selectedPlant,
                  userId!,
                  selectedImages!
              );
            },
            background: CustomColors.primary,
            foreground: CustomColors.white,
            label: "Submit"
        ) : Container(),

        selectedPlant > 0 ?
        QuestionList(isSpecialist: false) :
        Container()


      ],
    );
  }
  Widget _specialistWidget() {
    return Column(
      children: [
        Text('Specialist Menu', style: TextStyle(fontSize: 20)),
        const SizedBox(height: 20),
        QuestionList(isSpecialist: true)
      ],
    );
  }
}

