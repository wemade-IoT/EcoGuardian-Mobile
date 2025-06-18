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


  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    typeController = TextEditingController();
    waterThresholdController = TextEditingController();
    lightThresholdController = TextEditingController();
    temperatureThresholdController = TextEditingController();

    if (widget.plant != null) {
      nameController.text = widget.plant!.name;
      typeController.text = widget.plant!.type;
      waterThresholdController.text = widget.plant!.waterThreshold.toString();
      lightThresholdController.text = widget.plant!.lightThreshold.toString();
      temperatureThresholdController.text = widget.plant!.temperatureThreshold.toString();
    }
  }

  @override
  void dispose(){
    super.dispose();
    nameController.dispose();
    typeController.dispose();
    waterThresholdController.dispose();
    lightThresholdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final plantProvider = context.watch<PlantProvider>();
    return AlertDialog(
      title: Column(
        spacing: 10,
        children: [
          Text(
              widget.plant != null ? "Update plant" : "Add new plant",
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black
            ),
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
                        onValidate: (_){
                          return plantProvider.validateName(nameController.text);
                        }
                      ),
                      CustomTextField(
                          controller: typeController,
                          hintText: "Give plant type",
                          label: "Type",
                        onValidate: (_){
                            return plantProvider.validateType(typeController.text);
                        },
                      ),
                      CustomTextField(
                          controller: waterThresholdController,
                          hintText: "Give water threshold",
                          label: "WaterThreshold",
                        onValidate: (_){
                            return plantProvider.validateThresholds(waterThresholdController.text);
                        },
                      ),
                      CustomTextField(
                          controller: lightThresholdController,
                          hintText: "Give light threshold",
                          label: "LightThreshold",
                        onValidate:(_){
                            return plantProvider.validateThresholds(lightThresholdController.text);
                        },
                      ),
                      CustomTextField(
                        controller: temperatureThresholdController,
                        hintText: "Give temperature threshold",
                        label: "Temperature Threshold",
                        onValidate:(_){
                          return plantProvider.validateThresholds(temperatureThresholdController.text);
                        },
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: CustomElevatedButton(
                            onPressed: ()async{
                              if(widget.plant != null){
                                 final newPlantInformation = PlantDto(
                                     name: nameController.text,
                                     id: widget.plant!.id,
                                     type: typeController.text,
                                     isPlantation: widget.plant!.isPlantation,
                                     areaCoverage: widget.plant!.areaCoverage,
                                     userId:widget.plant!.userId,
                                     waterThreshold: int.parse(waterThresholdController.text),
                                     temperatureThreshold: int.parse(temperatureThresholdController.text),
                                     lightThreshold: int.parse(lightThresholdController.text),
                                     createdAt: widget.plant!.createdAt,
                                     updatedAt: widget.plant!.updatedAt,
                                     stateId: widget.plant!.stateId
                                 );
                                 try{
                                   await plantProvider.updatePlant(newPlantInformation);
                                   context.push("/monitoring");
                                 } catch (e){
                                   await showDialog(
                                       context: context,
                                       builder: (BuildContext context){
                                         return CustomDialog(
                                             title: "An error has ocurred",
                                             content: "An error has ocurred while trying to update your plant, please try again",
                                             isSuccess: false,
                                             onConfirm: (){

                                             },
                                             onCancel: (){

                                             }
                                         );
                                       }
                                   );
                                 }
                              }else{
                                final userId = await StorageHelper.getUserId();
                                final newPlantInformation = PlantDto(
                                    name: nameController.text,
                                    id: 0,
                                    type: typeController.text,
                                    isPlantation: false,
                                    areaCoverage: 0,
                                    userId: userId!,
                                    waterThreshold: int.parse(waterThresholdController.text),
                                    temperatureThreshold: int.parse(temperatureThresholdController.text),
                                    lightThreshold: int.parse(lightThresholdController.text),
                                    createdAt: DateTime.now(),
                                    updatedAt: DateTime.now(),
                                    stateId: 1
                                );
                                try{
                                  await plantProvider.createPlant(newPlantInformation);
                                  context.push("/monitoring");
                                } catch (e){
                                  await showDialog(
                                      context: context,
                                      builder: (BuildContext context){
                                        return CustomDialog(
                                            title: "An error has ocurred",
                                            content: "An error has ocurred while trying to register your plant, please try again",
                                            isSuccess: false,
                                            onConfirm: (){

                                            },
                                            onCancel: (){

                                            }
                                        );
                                      }
                                  );
                                }
                              }
                            },
                            background: CustomColors.primary,
                            foreground: Colors.white,
                            label: "Submit"
                        ),
                      )
                    ],
                )
            ),
        ],
      ),
    );
  }
}
