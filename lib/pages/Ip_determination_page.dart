import 'package:flutter/material.dart';
import 'package:medihive_1_/constant/ApiRoutes.dart';
import 'package:medihive_1_/constant/AppDimensions.dart';
import 'package:medihive_1_/helper/Routes.dart';
import 'package:medihive_1_/helper/Snack_Dialog.dart';
import 'package:medihive_1_/shared/Custom_Button.dart';
import 'package:medihive_1_/shared/Custom_TextFormField.dart';

class IpDeterminationPage extends StatefulWidget {
  IpDeterminationPage({super.key});

  @override
  State<IpDeterminationPage> createState() => _IpDeterminationPageState();
}

class _IpDeterminationPageState extends State<IpDeterminationPage> {
  String ip = '';

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Appdimensions.init(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(25),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              CustomeTextFormField(
                title: 'اي بي سيدي',
                isNumber: true,
                hintText: ' the IP for the local host Getway ',
                onChanged: (data) {
                  ip = data;
                },
              ),
              SizedBox(
                height: 50,
              ),
              CustomButton(
                  buttonText: 'Submit',
                  onTap: () async {
                    if (ip.trim().isNotEmpty) {
                      changeIPMethod(ip: ip);
                      Navigator.pushNamed(context, Routes.splashScreen);
                      // showErrorSnackBar(context, ip);
                    } else {
                      showErrorSnackBar(context, 'Incorrect formula');
                    }
                  })
            ],
          ),
        ),
      )),
    );
  }
}
