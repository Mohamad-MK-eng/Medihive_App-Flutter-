import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/helper/Routes.dart';
import 'package:medihive_1_/models/Doctor.dart';
import 'package:medihive_1_/pages/User_Patient/DoctorPages/cubit/doctor_cubit.dart';
import 'package:medihive_1_/pages/User_Patient/DoctorPages/widgets/RatingContainer.dart';
import 'package:medihive_1_/shared/Custom_Button.dart';
import 'package:medihive_1_/shared/Profile_image_container.dart';

class DoctordetailsPage extends StatelessWidget {
  DoctordetailsPage({required this.doctor});
  Doctor doctor;
  @override
  Widget build(BuildContext context) {
    // على الأغلب هو حط Future Builder
    if (BlocProvider.of<DoctorCubit>(context).doctorDetails == null) {
      BlocProvider.of<DoctorCubit>(context)
          .loadDoctorDetails(doctor.id, context);
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: BlocBuilder<DoctorCubit, DoctorState>(
        builder: (context, state) {
          if (state is DocotrDetailsSuccess ||
              BlocProvider.of<DoctorCubit>(context).doctorDetails != null) {
            final details = BlocProvider.of<DoctorCubit>(context).doctorDetails;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      width: double.infinity,
                      height: 0.01,
                    ),
                    ProfileImageContainer(
                        width: 216, hieght: 160, Image_path: doctor.image_path),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      // Doctor name here
                      'Dr.${doctor.first_name + doctor.last_name}',
                      style: TextStyle(
                        color: const Color(0xFF1E1F2E),
                        fontSize: 24,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      // Doctor speciality here
                      doctor.specialty,
                      style: TextStyle(
                        color: geryinAuthTextField /* Dark-Gray */,
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // here parsing the rates information
                        PatientCounterContainer(
                          patient_num: details!.reviews_count,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ExperienceContainer(
                          exp_years: doctor.experience_years,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Ratingcontainer(
                          rate: details.rate,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Row(
                      children: [
                        Text(
                          'About Doctor',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Jomolhari',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.60,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.info_outline,
                          color: hardmintGreen,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        // here is the bio of doctor
                        details.bio != null
                            ? details.bio!
                            : 'This is the bio of the Doctor',
                        style: TextStyle(
                          color: geryinAuthTextField /* Dark-Gray */,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.25,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      children: [
                        Text(
                          'Work Days',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Jomolhari',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.60,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.info_outline,
                          color: hardmintGreen,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        // working days here if doctor is active else Note instead
                        _getWorkingDaysifDocIsActive(details),
                        style: const TextStyle(
                          color: geryinAuthTextField,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          letterSpacing: 0.39,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Fees :  ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Jomolhari',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.60,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Text(
                            // here is the fees
                            details.fee != null ? "${details.fee}\$" : "",
                            style: const TextStyle(
                              color: hardmintGreen,
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                              letterSpacing: 3.40,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    if (details.is_active)
                      CustomButton(
                        buttonText: 'Set Appointment',
                        onTap: () async {
                          Map<String, dynamic> argument = {
                            'doctor_id': doctor.id,
                            'doctor_fee': details.fee ?? 14.5
                          };
                          Navigator.pushNamed(
                              context, Routes.dateAndTimeSelectionPage,
                              arguments: argument);
                        },
                        isWideButtons: true,
                        isFontBig: true,
                      )
                  ],
                ),
              ),
            );
          } else if (state is DoctorFailed) {
            return Container(
              child: Center(child: Text(state.errorMessage!)),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: lightBlue,
              ),
            );
          }
        },
      ),
    );
  }

  String _getWorkingDaysifDocIsActive(DoctorDetails? details) {
    if (details!.is_active) {
      return details.workingDays.isNotEmpty
          ? details.workingDays.join('_')
          : 'Sun_Tue_Thu';
    } else {
      return 'Sorry!, Doctor is not avalilable for now';
    }
  }
}
