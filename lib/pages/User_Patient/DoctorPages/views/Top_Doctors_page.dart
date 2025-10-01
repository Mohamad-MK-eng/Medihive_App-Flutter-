import 'package:flutter/material.dart';
import 'package:medihive_1_/helper/Routes.dart';
import 'package:medihive_1_/models/Doctor.dart';
import 'package:medihive_1_/shared/DoctorContainer.dart';

class TopDoctorsPage extends StatelessWidget {
  TopDoctorsPage({required this.topDoctors});
  List<Doctor> topDoctors;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text('Top Doctors'),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: topDoctors.length, // topDocctors.length
            itemBuilder: (context, index) {
              final doctor = topDoctors[index];
              return GestureDetector(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Doctorcontainer(
                      image_path:
                          doctor.image_path, // doctors[index].image_path
                      doctor_name: doctor.first_name +
                          ' ${doctor.last_name}', // doctors[index].first_name
                      doctor_speciality:
                          doctor.specialty, //doctors[index].last_name
                      experience_years: doctor
                          .experience_years, //doctors[index].experience_years
                      rate: doctor.rate //doctors[index].rate
                      ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, Routes.doctorDetailsPage,
                      arguments: doctor // here is the doctor id
                      );
                },
              );
            }));
  }
}
