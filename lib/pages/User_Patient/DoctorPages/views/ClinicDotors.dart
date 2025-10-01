import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/helper/Routes.dart';
import 'package:medihive_1_/pages/User_Patient/DoctorPages/cubit/doctor_cubit.dart';
import 'package:medihive_1_/shared/DoctorContainer.dart';

class ClinicDoctors extends StatelessWidget {
  ClinicDoctors({required this.attributes});
  Map<String, dynamic> attributes;
  @override
  Widget build(BuildContext context) {
    if (BlocProvider.of<DoctorCubit>(context).doctors.isEmpty)
      BlocProvider.of<DoctorCubit>(context)
          .loadClinicDortor(attributes['clinic_id'], context);

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text('${attributes['clinic_name']}'),
          centerTitle: true,
        ),
        body: BlocBuilder<DoctorCubit, DoctorState>(
          builder: (context, state) {
            if (state is DoctorsListSuccess ||
                BlocProvider.of<DoctorCubit>(context).doctors.isNotEmpty) {
              final doctors = BlocProvider.of<DoctorCubit>(context).doctors;
              return ListView.builder(
                itemCount: doctors.length, // doctors.length
                itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.doctorDetailsPage,
                          arguments: doctors[index] // here is the doctor id
                          );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8),
                      child: Doctorcontainer(
                          image_path: doctors[index].image_path,
                          doctor_name: doctors[index].first_name +
                              ' ' +
                              doctors[index].last_name,
                          doctor_speciality: '${doctors[index].specialty}',
                          experience_years: doctors[index].experience_years,
                          rate: doctors[index].rate),
                    )),
              );
            } else if (state is DoctorFailed) {
              return Container(
                child: Text(state.errorMessage!),
              );
            } else {
              return Center(
                child: const CircularProgressIndicator(
                  color: lightBlue,
                ),
              );
            }
          },
        ));
  }
}
