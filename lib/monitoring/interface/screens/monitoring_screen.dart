import 'package:ecoguardian/monitoring/interface/providers/plant_provider.dart';
import 'package:ecoguardian/monitoring/interface/widgets/plant_dialog.dart';
import 'package:ecoguardian/monitoring/interface/widgets/plant_list.dart';
import 'package:ecoguardian/public/interface/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/theme/app_theme.dart';

class MonitoringScreen extends StatefulWidget {

  static const String name = 'monitoring_screen';

  const MonitoringScreen({super.key});

  @override
  State<MonitoringScreen> createState() => _MonitoringScreenState();
}

class _MonitoringScreenState extends State<MonitoringScreen> {


  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final plantProvider = context.watch<PlantProvider>();
    return Scaffold(
      backgroundColor:  MainTheme.background,
      body: SingleChildScrollView(
        child: Column(
              children: [
                Container(
                      decoration: BoxDecoration(
                        color: CustomColors.lightGrey,
                        borderRadius: BorderRadius.circular(20)
                      ),
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        margin:  const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                        child: Column(
                          spacing: 5,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Plants",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          PlantList(plantsDto:plantProvider.plants),
                            SizedBox(
                              width: double.infinity,
                              child: CustomElevatedButton(
                                  onPressed: ()async{
                                    await showDialog(
                                        context: context,
                                        builder: (BuildContext context){
                                          return PlantDialog();
                                        }
                                    );
                                  },
                                  background: CustomColors.primary,
                                  foreground: Colors.white,
                                  label: "+"
                              ),
                            ),
                          ],
                        )
                    ),
              ],
            ),
        ),
    );
  }
}