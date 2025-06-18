import 'package:ecoguardian/monitoring/domain/dto/plant.dto.dart';
import 'package:ecoguardian/monitoring/interface/widgets/plant_item.dart';
import 'package:flutter/cupertino.dart';

class PlantList extends StatelessWidget {
  final List<PlantDto> plantsDto;
  const PlantList({super.key, required this.plantsDto});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: plantsDto.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index){
          return PlantItem(plant: plantsDto[index]);
        }
    );
  }
}
