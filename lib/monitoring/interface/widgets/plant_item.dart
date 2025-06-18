import 'package:ecoguardian/monitoring/domain/dto/plant.dto.dart';
import 'package:ecoguardian/monitoring/interface/providers/plant_provider.dart';
import 'package:ecoguardian/monitoring/interface/screens/plant_information_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../config/theme/app_theme.dart';

class PlantItem extends StatelessWidget {
  final PlantDto plant;
  const PlantItem({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    final plantProvider = context.watch<PlantProvider>();
    Map<int,Color> statusColors = {
      1: CustomColors.primary,
      2: CustomColors.lightGreen,
      3: Colors.red
    };
    Map<int,String> statusLabels = {
      1: "Healthy",
      2: "Unhealthy",
      3: "Warning"
    };
    return  Dismissible(
      key: Key(plant.id.toString()),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (_)async{
        await plantProvider.deletePlant(plant);
      },
      child: GestureDetector(
        onTap: (){
          plantProvider.selectPlant(plant);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_)
                  => PlantInformationScreen(
                      plantDto: plant)
              )
          );
        },
        child: Card(
          color: MainTheme.background,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 15,
                    child: CircleAvatar(
                      backgroundColor: statusColors[plant.stateId],
                    ),
                  ),
                  Text(
                      plant.name,
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black
                    ),
                  ),
                 Row(
                   spacing: 20,
                   children: [
                     Text(
                       plant.type,
                       style: TextStyle(
                           fontSize: 15.0,
                           color: CustomColors.grey
                       ),
                     ),
                     Row(
                       spacing: 10,
                       children: [
                         SizedBox(
                           width: 15,
                           child: CircleAvatar(
                             backgroundColor: statusColors[plant.stateId],
                           ),
                         ),
                         Text(
                           statusLabels[plant.stateId]!,
                           style: TextStyle(
                               fontSize: 15.0,
                               color: CustomColors.grey
                           ),
                         )
                       ],
                     )
                   ],
                 )

                ],
              ),
            ),
        ),
      ),
    );
  }
}
