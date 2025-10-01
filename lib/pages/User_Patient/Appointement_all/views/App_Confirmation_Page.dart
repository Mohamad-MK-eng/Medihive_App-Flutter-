import 'package:flutter/material.dart';
import 'package:medihive_1_/constant/AppDimensions.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/helper/Routes.dart';
import 'package:medihive_1_/models/Arguments_Models/App_success_info.dart';
import 'package:medihive_1_/shared/Custom_Button.dart';

class AppConfirmationPage extends StatelessWidget {
  AppConfirmationPage({required this.successInfo});
  AppSuccessInfo successInfo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: Appdimensions.getWidth(60),
            ),
            Icon(
              Icons.check_circle,
              size: Appdimensions.getHight(150),
              color: hardmintGreen,
            ),
            const SizedBox(
              height: 30,
            ),
            const FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Operation Done Succesfluy',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF003692),
                  fontSize: 22,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w600,
                  height: 0.33,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Appointment:',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: geryinAuthTextField,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '${successInfo.clinic_name} Clinic\nwith\nDr ${successInfo.docotr_name}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              successInfo.date,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: hardmintGreen,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              successInfo.time,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: hardmintGreen,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: Appdimensions.getHight(40),
            ),
            const Text(
              'Stay toned for any updates',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFFA9A9A9) /* Dark-Gray */,
                fontSize: 14,
                fontFamily: 'Arial',
                fontWeight: FontWeight.w400,
                height: 0.86,
              ),
            ),
            const Expanded(child: SizedBox()),
            CustomButton(
              buttonText: 'Go Home',
              onTap: () async {
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.patientHome, (context) => false);
              },
              isWideButtons: true,
            ),
            SizedBox(
              height: Appdimensions.getHight(60),
            )
          ],
        ));
  }
}
