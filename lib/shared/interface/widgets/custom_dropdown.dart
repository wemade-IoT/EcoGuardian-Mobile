import 'package:ecoguardian/monitoring/domain/dto/plant.dto.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final List<PlantDto>? options;
  final List<String>?periods;
  final int? initialValue;
  final void Function(int?)? onChanged;

  const CustomDropdown({
    super.key,
    this.options,
    this.periods,
    this.initialValue,
    this.onChanged,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  int? selectedValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<dynamic>(
        value: selectedValue,
        isExpanded: true,
        underline: const SizedBox(),
        icon: const Icon(Icons.arrow_drop_down),
        items: widget.options != null ?
        widget.options!.map((option) {
          return DropdownMenuItem(
            value: option.id,
            child: Text(option.name),
          );
        }).toList() :
        (widget.periods != null ?
        List.generate(widget.periods!.length, (index) {
          return DropdownMenuItem(
            value: index,
            child: Text(widget.periods![index]),
          );
        }) :
        <DropdownMenuItem>[]
        ),
        onChanged: (newValue) {
          setState(() {
            selectedValue = newValue;
          });
          if (widget.onChanged != null) {
            widget.onChanged!(newValue);
          }
        },
      ),
    );
  }
}
