import 'package:flutter/material.dart';
import 'package:medihive_1_/constant/AppDimensions.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';

class ClinicRectangle extends StatelessWidget {
  ClinicRectangle({required this.name, required this.imagePath});
  String name;
  String imagePath;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Appdimensions.getWidth(120),
      height: Appdimensions.getHight(120),
      decoration: ShapeDecoration(
        color: lightSky,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x26616161),
            blurRadius: 3,
            offset: Offset(1, 3),
            spreadRadius: 1,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: Appdimensions.getHight(42),
              width: Appdimensions.getWidth(42),
              clipBehavior: Clip.antiAlias,
              //  Image.asset(AuthImage),
              decoration: BoxDecoration(
                  //  color: Colors.transparent,
                  ),
              child: Image.network(
                imagePath,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error); // أو صورة افتراضية
                },
              )),
          /*     child: CircleAvatar(
                      radius: 10,
                      backgroundImage: NetworkImage(imagePath),
                      backgroundColor: lightSky, // أو لون الخلفية
                    ) */

          const SizedBox(
            height: 20,
          ),
          Text(
            name,
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
    );
  }
}
