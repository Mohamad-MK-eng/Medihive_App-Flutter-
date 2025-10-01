import 'package:flutter/material.dart';
import 'package:medihive_1_/constant/AppDimensions.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';

class EarliestDateContainer extends StatelessWidget {
  EarliestDateContainer(
      {required this.full_day, required this.time, required this.isSelected});
  String full_day;
  String time;
  bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      height: Appdimensions.getWidth(70),
      decoration: ShapeDecoration(
        color: isSelected ? mintGreen : Color(0xFFDEEDFC),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        shadows: [
          const BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              full_day,
              style: TextStyle(
                color: isSelected ? Colors.black : Color(0xFF707070),
                fontSize: 20,
                fontFamily: 'Arial',
                fontWeight: FontWeight.w400,
                height: 0.60,
                letterSpacing: 0.60,
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                time,
                style: TextStyle(
                  color: isSelected ? Colors.black : Color(0xFF707070),
                  fontSize: 16,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w400,
                  height: 0.86,
                  letterSpacing: 0.42,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              const Icon(
                Icons.timelapse_outlined,
                size: 18,
              )
            ],
          ),
        ],
      ),
    );
  }
}
