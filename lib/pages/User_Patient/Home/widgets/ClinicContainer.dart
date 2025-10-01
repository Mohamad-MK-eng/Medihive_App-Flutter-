import 'package:flutter/material.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';

import '../../../../constant/AppDimensions.dart';

class ClinicContainer extends StatefulWidget {
  ClinicContainer({required this.name, required this.imagePath});
  String name;
  String imagePath;

  @override
  State<ClinicContainer> createState() => _ClinicContainerState();
}

class _ClinicContainerState extends State<ClinicContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 18),
      child: Container(
          width: Appdimensions.screenWidth * (115) / Appdimensions.vPhoneWidth,
          height:
              Appdimensions.screenHieght * (110) / Appdimensions.vPhoneHight,
          decoration: ShapeDecoration(
              color: lightSky,
              shape:
                  OvalBorder(side: BorderSide(width: 1.5, color: mintGreen))),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: Appdimensions.getHight(55),
                  width: Appdimensions.getWidth(55),
                  clipBehavior: Clip.antiAlias,
                  //  Image.asset(AuthImage),
                  decoration: BoxDecoration(
                      //  color: Colors.transparent,
                      ),
                  child: Image.network(
                    widget.imagePath,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.error); // أو صورة افتراضية
                    },
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: hardGrey,
                    fontSize: 12,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                    height: 1.48,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
