import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ecoguardian/shared/infrastructure/helpers/storage_helper.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../config/theme/app_theme.dart';
import '../../../public/interface/widgets/custom_elevated_button.dart';
import '../providers/question_provider.dart';

class QuestionDialog extends StatefulWidget {
  final int selectedPlant;
  final String role;
  final List<dynamic>? selectedImages;

  const QuestionDialog({
    Key? key,
    required this.selectedPlant,
    required this.role,
    this.selectedImages,
  }) : super(key: key);

  @override
  _QuestionDialogState createState() => _QuestionDialogState();
}

class _QuestionDialogState extends State<QuestionDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _questionController = TextEditingController();
  List<XFile>? selectedImages;

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
    final questionProvider = context.watch<QuestionProvider>();
    return AlertDialog(
      backgroundColor: CustomColors.white,
      title: const Text('Create question'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            widget.selectedPlant > 0
                ? TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            )
                : Container(),

            const SizedBox(height: 16),
            widget.selectedPlant > 0
                ? TextField(
              controller: _questionController,
              decoration: InputDecoration(
                labelText: widget.role == 'domestic'
                    ? 'Question about your plants'
                    : 'Question about your plantations',
                border: const OutlineInputBorder(),
              ),
            )
                : Container(),

            const SizedBox(height: 16),

            widget.selectedPlant > 0
                ? GestureDetector(
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
                    itemBuilder: (BuildContext context, int index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(selectedImages![index].path),
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
                : Container(),

            const SizedBox(height: 16),
            widget.selectedPlant > 0
                ? CustomElevatedButton(
              onPressed: () async {
                final userId = await StorageHelper.getUserId();
                questionProvider.createQuestion(
                  _titleController.text,
                  _questionController.text,
                  widget.selectedPlant,
                  userId!,
                  selectedImages!,
                );
                context.go("/consulting");
                Navigator.pop(context);
              },
              background: CustomColors.primary,
              foreground: CustomColors.white,
              label: "Submit",
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}
