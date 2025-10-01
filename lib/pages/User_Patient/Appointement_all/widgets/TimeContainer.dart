import 'package:flutter/material.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';

class Timecontainer extends StatelessWidget {
  Timecontainer({required this.isSelected, required this.time});
  bool isSelected;
  String time;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 30,
      padding: const EdgeInsets.only(top: 2.5, left: 5, right: 5, bottom: 2.5),
      decoration: ShapeDecoration(
        color: isSelected ? mintGreen.withOpacity(0.75) : lightSky,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            time,
            style: TextStyle(
              color: isSelected ? Colors.black : Color(0xFF707070),
              fontSize: 14,
              fontFamily: 'Arial',
              fontWeight: FontWeight.w400,
              height: 0.86,
              letterSpacing: 0.42,
            ),
          ),
          Icon(
            Icons.timelapse_outlined,
            size: 18,
          )
        ],
      ),
    );
  }
}
