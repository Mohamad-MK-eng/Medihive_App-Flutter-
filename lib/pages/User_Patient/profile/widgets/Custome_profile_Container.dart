import 'package:flutter/material.dart';
import 'package:medihive_1_/constant/AppDimensions.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';

class CustomeProfileContainer extends StatelessWidget {
  CustomeProfileContainer(
      {required this.index,
      this.selectedIndex = 0,
      required this.onSelectedIndex});
  int index;
  int selectedIndex;
  Function(int) onSelectedIndex;

  @override
  Widget build(BuildContext context) {
    final isSelected = index == selectedIndex;
    return Container(
      width: Appdimensions.getWidth(120),
      height: Appdimensions.getHight(75),
      decoration: ShapeDecoration(
        color: isSelected ? mintGreen : lightSky,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x26616161),
            blurRadius: 2.96,
            offset: Offset(0, 0.99),
            spreadRadius: 0,
          )
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            index == 1
                ? Icon(
                    Icons.edit,
                    size: 30,
                    color: isSelected ? Colors.white : lightBlue,
                  )
                : index == 2
                    ? Icon(Icons.security,
                        size: 30, color: isSelected ? Colors.white : lightBlue)
                    : Icon(Icons.payment,
                        size: 30, color: isSelected ? Colors.white : lightBlue),
            const SizedBox(
              height: 5,
            ),
            Text(
              index == 1
                  ? 'Edit Profile'
                  : index == 2
                      ? 'Security'
                      : 'Payment info',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.black : hardGrey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
