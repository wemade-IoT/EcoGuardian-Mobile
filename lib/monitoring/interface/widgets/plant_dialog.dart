import 'dart:io';
import 'package:ecoguardian/config/theme/app_theme.dart';
import 'package:ecoguardian/iam/interface/providers/auth_provider.dart';
import 'package:ecoguardian/monitoring/domain/dto/plant.dto.dart';
import 'package:ecoguardian/monitoring/interface/providers/plant_provider.dart';
import 'package:ecoguardian/monitoring/interface/screens/monitoring_screen.dart';
import 'package:ecoguardian/public/interface/widgets/custom_dialog.dart';
import 'package:ecoguardian/public/interface/widgets/custom_elevated_button.dart';
import 'package:ecoguardian/public/interface/widgets/custom_text_field.dart';
import 'package:ecoguardian/shared/infrastructure/helpers/storage_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PlantDialog extends StatefulWidget {
  PlantDto? plant;
  PlantDialog({super.key, this.plant});

  @override
  State<PlantDialog> createState() => _PlantDialogState();
}

class _PlantDialogState extends State<PlantDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController typeController;
  late TextEditingController waterThresholdController;
  late TextEditingController lightThresholdController;
  late TextEditingController temperatureThresholdController;
  late TextEditingController areaCoverageController;
  XFile? plantImageFile;
  bool isEnterprise = false;

  Future<void> pickImageFromGallery() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        plantImageFile = pickedFile;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final isEnterpriseResult = await authProvider.isEnterprise();
      setState(() {
        isEnterprise = isEnterpriseResult;
      });
    });
    nameController = TextEditingController();
    typeController = TextEditingController();
    waterThresholdController = TextEditingController();
    lightThresholdController = TextEditingController();
    temperatureThresholdController = TextEditingController();
    areaCoverageController = TextEditingController();

    if (widget.plant != null) {
      nameController.text = widget.plant!.name;
      typeController.text = widget.plant!.type;
      waterThresholdController.text = widget.plant!.waterThreshold.toString();
      lightThresholdController.text = widget.plant!.lightThreshold.toString();
      temperatureThresholdController.text =
          widget.plant!.temperatureThreshold.toString();
      areaCoverageController.text = widget.plant!.areaCoverage.toString();
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    typeController.dispose();
    waterThresholdController.dispose();
    lightThresholdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final plantProvider = context.watch<PlantProvider>();
    return SingleChildScrollView(
      child: AlertDialog(
        title: Column(
          spacing: 10,
          children: [
            Text(
              widget.plant != null ? "Update plant" : "Add new plant",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
            Form(
              key: _formKey,
              child: Column(
                spacing: 20,
                children: [
                  CustomTextField(
                    controller: nameController,
                    hintText: "Give plant name",
                    label: "Name",
                    onValidate: (_) {
                      return plantProvider.validateName(nameController.text);
                    },
                  ),
                  widget.plant == null
                      ? GestureDetector(
                        onTap: pickImageFromGallery,
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey[200],
                          ),
                          child: Center(
                            child:
                                plantImageFile == null
                                    ? Icon(
                                      Icons.add_a_photo,
                                      color: Colors.grey[700],
                                      size: 50,
                                    )
                                    : ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(
                                        File(plantImageFile!.path),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                          ),
                        ),
                      )
                      : Container(),
                  Container(),
                  CustomTextField(
                    controller: typeController,
                    hintText: "Give plant type",
                    label: "Type",
                    onValidate: (_) {
                      return plantProvider.validateType(typeController.text);
                    },
                  ),
                  CustomTextField(
                    controller: waterThresholdController,
                    hintText: "Give water threshold",
                    label: "WaterThreshold",
                    onValidate: (_) {
                      return plantProvider.validateThresholds(
                        waterThresholdController.text,
                      );
                    },
                  ),
                  CustomTextField(
                    controller: lightThresholdController,
                    hintText: "Give light threshold",
                    label: "LightThreshold",
                    onValidate: (_) {
                      return plantProvider.validateThresholds(
                        lightThresholdController.text,
                      );
                    },
                  ),
                  CustomTextField(
                    controller: temperatureThresholdController,
                    hintText: "Give temperature threshold",
                    label: "Temperature Threshold",
                    onValidate: (_) {
                      return plantProvider.validateThresholds(
                        temperatureThresholdController.text,
                      );
                    },
                  ),
                  isEnterprise
                      ? CustomTextField(
                        controller: areaCoverageController,
                        hintText: "Give Area coverage (KM)",
                        label: "Area coverage",
                        onValidate: (_) {
                          return plantProvider.validateAreaCoverage(
                            areaCoverageController.text,
                          );
                        },
                      )
                      : Container(),
                  SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      onPressed: () async {
                        if (widget.plant != null) {
                          final newPlantInformation = PlantDto(
                            name: nameController.text,
                            id: widget.plant!.id,
                            type: typeController.text,
                            isPlantation: widget.plant!.isPlantation,
                            areaCoverage:
                                !isEnterprise
                                    ? 0
                                    : int.parse(areaCoverageController.text),
                            userId: widget.plant!.userId,
                            waterThreshold: int.parse(
                              waterThresholdController.text,
                            ),
                            temperatureThreshold: int.parse(
                              temperatureThresholdController.text,
                            ),
                            lightThreshold: int.parse(
                              lightThresholdController.text,
                            ),
                            createdAt: widget.plant!.createdAt,
                            updatedAt: widget.plant!.updatedAt,
                            stateId: widget.plant!.stateId,
                          );
                          try {
                            await plantProvider.updatePlant(
                              newPlantInformation,
                            );
                            context.push(
                              "/installations",
                              extra: newPlantInformation,
                            );
                          } catch (e) {
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialog(
                                  title: "An error has ocurred",
                                  content:
                                      "An error has ocurred while trying to update your plant, please try again",
                                  isSuccess: false,
                                  onConfirm: () {},
                                  onCancel: () {},
                                );
                              },
                            );
                          }
                        } else {
                            final newPlantInformation = PlantDto(
                              name: nameController.text,
                              id: 0,
                              type: typeController.text,
                              image: plantImageFile,
                              isPlantation: false,
                              areaCoverage:
                                  !isEnterprise
                                      ? 0
                                      : int.parse(areaCoverageController.text),
                              userId: 0,
                              waterThreshold: int.parse(
                                waterThresholdController.text,
                              ),
                              temperatureThreshold: int.parse(
                                temperatureThresholdController.text,
                              ),
                              lightThreshold: int.parse(
                                lightThresholdController.text,
                              ),
                              createdAt: DateTime.now(),
                              updatedAt: DateTime.now(),
                              stateId: 1,
                            );

                            Navigator.of(context).pop();

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                  'You can only have a maximum of 5 plants registered',
                                ),
                                backgroundColor: Colors.orange[400],
                                duration: const Duration(seconds: 2),
                              ),
                            );

                            context.push(
                              "/installations",
                              extra: newPlantInformation,
                            );

                            return;
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
