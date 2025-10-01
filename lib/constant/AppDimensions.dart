import 'package:flutter/material.dart';

class Appdimensions {
  static late double screenWidth;
  static late double screenHieght;

  static double vPhoneWidth = 412;
  static double vPhoneHight = 905;

  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHieght = size.height;
  }

  static double getWidth(int width) => screenWidth * (width) / vPhoneWidth;

  static double getHight(int hight) => screenHieght * (hight) / vPhoneHight;
}
