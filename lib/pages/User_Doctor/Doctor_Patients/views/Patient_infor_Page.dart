import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/constant/AppDimensions.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/cubits/Profile_Cubit/profile_cubit.dart';
import 'package:medihive_1_/shared/Custom_TextFormField.dart';
import 'package:medihive_1_/shared/Profile_image_container.dart';
import 'package:medihive_1_/shared/loadingIndecator.dart';

class PatientInfoPage extends StatelessWidget {
  PatientInfoPage({required this.patient_id});
  int patient_id;
  @override
  Widget build(BuildContext context) {
    final thisCubit = context.read<ProfileCubit>();

    thisCubit.getPatProForDoctor(context: context, patient_id: patient_id);

    return Scaffold(
      backgroundColor: light_suger_white,
      appBar: AppBar(
        backgroundColor: midnigth_bule,
        foregroundColor: Colors.white,
        title: const Text(
          'Patient Profile',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 25, left: 25),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          buildWhen: (previous, current) {
            return ModalRoute.of(context)?.isCurrent == true;
          },
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Loadingindecator();
            } else if (state is ProfileFailed) {
              return Center(
                child: Text(
                  state.errorMessage!,
                  textAlign: TextAlign.center,
                ),
              );
            } else if (state is ProfileSuccess) {
              final data = thisCubit.pat_Profile!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: Appdimensions.getHight(50),
                  ),
                  Row(
                    children: [
                      ProfileImageContainer(
                        Image_path: data.profile_picture_url,
                        width: 125,
                        hieght: 125,
                        // strok_color: Colors.grey.shade100,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${data.first_name} ${data.last_name}',
                            overflow: TextOverflow.visible,
                            maxLines: null,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                              fontFamily: 'Arial',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            data.phoneNum ?? '',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: Colors.black45,
                          strokeAlign: BorderSide.strokeAlignCenter,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomeTextFormField(
                    title: 'Address',
                    hintText: data.address,
                    title_color: hardmintGreen,
                    strok_color: midnigth_bule,
                    readOnly: true,
                    maxLines: 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AttributesContainer(
                            title: 'Age', content: data.birthDate),
                        AttributesContainer(
                            title: 'Gender', content: data.medicalInfo?.gender),
                        AttributesContainer(
                            title: 'Blood Type',
                            content: data.medicalInfo?.bloodType),
                      ],
                    ),
                  ),
                  CustomeTextFormField(
                    title: 'Chronic_Conditions',
                    hintText: data.medicalInfo?.conditions,
                    title_color: hardmintGreen,
                    strok_color: midnigth_bule,
                    readOnly: true,
                    maxLines: 3,
                  ),
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  Container AttributesContainer(
      {required String title, required String? content}) {
    return Container(
      width: 86,
      //  height: 70,
      decoration: ShapeDecoration(
        color: const Color(0xFFF1F6FB),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: const Color(0xFF00BFA6),
                fontSize: 15,
                fontFamily: 'Arial',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Text(
            content ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Arial',
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}
