import 'package:flutter/material.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/helper/Routes.dart';
import 'package:medihive_1_/models/Clinic.dart';
import 'package:medihive_1_/pages/User_Patient/Home/widgets/Clinic_Rectangle.dart';

class Clinicspage extends StatelessWidget {
  Clinicspage({required this.clinic});
  List<Clinic> clinic;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'All Clinics',
          style: TextStyle(color: hardmintGreen, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 15, left: 15, top: 10),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, mainAxisSpacing: 11, crossAxisSpacing: 10),
            itemCount: clinic.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: ClinicRectangle(
                    name: clinic[index].name,
                    imagePath: clinic[index].imagePath),
                onTap: () {
                  Navigator.pushNamed(context, Routes.doctorClinicPage,
                      arguments: {
                        'clinic_id': clinic[index].id,
                        'clinic_name': clinic[index].name
                      });
                },
              );
            }),
      ),
    );
  }
}
