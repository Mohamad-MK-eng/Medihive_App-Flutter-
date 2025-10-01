import 'package:flutter/material.dart';
import 'package:medihive_1_/constant/AppDimensions.dart';
import 'package:medihive_1_/models/Clinic.dart';

import '../../../../constant/Colors&Fonts.dart';

class ClinicFilterDropDown extends StatefulWidget {
  ClinicFilterDropDown(
      {required this.items, required this.onSelectedItme, this.hintText});
  List<Clinic> items;

  Function(int?) onSelectedItme;
  String? hintText;

  @override
  State<ClinicFilterDropDown> createState() => _ClinicFilterDropDownState();
}

class _ClinicFilterDropDownState extends State<ClinicFilterDropDown> {
  Clinic? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Appdimensions.screenWidth / 1.65,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: mintGreen, width: 1.5),
      ),
      child: AbsorbPointer(
        absorbing: false,
        child: DropdownButtonHideUnderline(
          child: DropdownButton<Clinic>(
            value: selectedItem,
            hint: Align(
                alignment: Alignment.center,
                child: Text(
                    widget.hintText == null ? "Select yours" : widget.hintText!,
                    style: TextStyle(fontSize: 16, color: Colors.black))),
            icon: const Icon(Icons.arrow_drop_down, color: hardmintGreen),
            isExpanded: true, // ياخد كل العرض المتاح
            /* style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ), */
            dropdownColor: Colors.grey.shade100,

            items: widget.items.map((Clinic item) {
              return DropdownMenuItem<Clinic>(
                value: item,
                enabled: true,
                // هون لأول مرة فقط

                child: Align(
                  // alignment: Alignment.center,
                  child: Text(
                    item.name,
                    style: TextStyle(
                      fontFamily: montserratFont,
                      fontWeight: selectedItem == item
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: selectedItem == item ? Colors.black : hardGrey,
                    ),
                  ),
                ),
              );
            }).toList(),
            onChanged: (Clinic? newClinic) {
              setState(() {
                selectedItem = newClinic;
                setState(() {});
                widget.onSelectedItme(newClinic?.id);
              });
            },
          ),
        ),
      ),
    );
  }
}
