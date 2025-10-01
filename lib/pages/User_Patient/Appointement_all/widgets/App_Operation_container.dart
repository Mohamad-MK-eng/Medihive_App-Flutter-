import 'package:flutter/material.dart';
import 'package:medihive_1_/constant/AppDimensions.dart';
import 'package:medihive_1_/models/MyAppointment.dart';

class AppOperationContainer extends StatelessWidget {
  AppOperationContainer(
      {required this.tilte, required this.type, required this.onTap});
  String tilte;
  AppOperations type;
  VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    Color getColorByType(AppOperations type) {
      switch (type) {
        case AppOperations.cancel:
          return Colors.red;

        case AppOperations.edit:
        case AppOperations.rebook:
          return Colors.blueAccent;

        default:
          return Color.fromARGB(255, 255, 204, 0);
      }
    }

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(5),
        width: Appdimensions.getWidth(70),
        height: Appdimensions.getHight(30),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              tilte,
              style: TextStyle(
                color: getColorByType(type),
                fontSize: 14,
                fontFamily: 'Montserrat',
                letterSpacing: 1.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
