import 'package:flutter/material.dart';
import 'package:medihive_1_/constant/AppDimensions.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/constant/ImagePath.dart';

class Authlogo extends StatelessWidget {
  Authlogo({required this.islogin});
  bool islogin;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            height: islogin
                ? Appdimensions.getHight(200)
                : Appdimensions.getHight(150),
            width: islogin
                ? Appdimensions.getWidth(200)
                : Appdimensions.getWidth(150),
            child: Image.asset(AuthImage)),
        Text(
          'MediHive',
          style: TextStyle(
              color: hardBlue,
              fontSize: 36,
              fontFamily: montserratFont,
              fontWeight: FontWeight.w700,
              letterSpacing: 2),
        ),
        Text(
          'your health!, one tap away',
          style: TextStyle(
            color: hardBlue,
            fontSize: 16,
            fontFamily: jomalhiriFont,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 35,
        ),
      ],
    ));
  }
}
