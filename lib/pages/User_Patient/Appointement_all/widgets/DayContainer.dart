import 'package:flutter/material.dart';
import 'package:medihive_1_/constant/AppDimensions.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';

class Daycontainer extends StatelessWidget {
  Daycontainer(
      {required this.isSelcted,
      required this.month,
      required this.day_number,
      required this.day});
  String month;
  String day_number;
  String day;
  bool isSelcted;

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.5),
      width: Appdimensions.getWidth(80),
      height: Appdimensions.getHight(110),
      decoration: ShapeDecoration(
        color: isSelcted ? mintGreen : lightSky,
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              month,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'Jomolhari',
                fontWeight: FontWeight.w400,
                height: 1.20,
                letterSpacing: 0.30,
              ),
            ),
          ),
          Text(
            day_number,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontFamily: 'Jomolhari',
              fontWeight: FontWeight.w400,
              height: 0.50,
              letterSpacing: 0.72,
            ),
          ),
          Text(
            day,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 0.75,
              letterSpacing: 0.48,
            ),
          )
        ],
      ),
    );
  }
}
