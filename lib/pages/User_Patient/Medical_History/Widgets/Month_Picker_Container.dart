import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medihive_1_/constant/AppDimensions.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';

class MonthPickerContainer extends StatefulWidget {
  MonthPickerContainer({required this.onDateSlected});
  Function(String?) onDateSlected;
  @override
  State<MonthPickerContainer> createState() => _MonthPickerContainerState();
}

class _MonthPickerContainerState extends State<MonthPickerContainer> {
  String? dateSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Appdimensions.screenWidth / 1.65,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: mintGreen, width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            dateSelected != null ? dateSelected! : 'Slecte a Date!',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          GestureDetector(
            child: Icon(
              Icons.calendar_month,
              color: lightBlue,
              size: 30,
            ),
            onTap: () async {
              final datePicked = await showDatePicker(
                context: context,
                firstDate: DateTime(2025),
                lastDate: DateTime(2026),
              );
              if (datePicked != null) {
                dateSelected = DateFormat('yyyy-MM').format(datePicked);

                setState(() {});
                widget.onDateSlected(dateSelected);
              }
            },
          )
        ],
      ),
    );
  }
}
