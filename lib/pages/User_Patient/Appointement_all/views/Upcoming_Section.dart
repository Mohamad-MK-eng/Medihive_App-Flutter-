import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/constant/AppDimensions.dart';
import 'package:medihive_1_/helper/Routes.dart';
import 'package:medihive_1_/models/MyAppointment.dart';
import 'package:medihive_1_/pages/User_Patient/Appointement_all/cubit/my_appointment_cubit.dart';

import 'package:medihive_1_/pages/User_Patient/Appointement_all/widgets/Appointment_Container.dart';
import 'package:medihive_1_/shared/loadingIndecator.dart';

class UpcomingSection extends StatelessWidget {
  UpcomingSection({super.key});

  String? image_path = null;
  @override
  Widget build(BuildContext context) {
    final appCubit = context.read<MyAppointmentCubit>();

    if (appCubit.upcomingList.isEmpty) {
      appCubit.getUpcomingAppMethod(context: context);
    }

    return BlocBuilder<MyAppointmentCubit, MyAppointmentState>(
        buildWhen: (previous, current) {
      return current is UpcomingLoading ||
          current is UpcomingFailed ||
          current is UpcomingSuccess;
    }, builder: (context, state) {
      if (state is UpcomingLoading) {
        return const Loadingindecator();
      } else if (state is UpcomingFailed) {
        return Center(
          child: Text(state.errorMessage!),
        );
      } else if (state is UpcomingSuccess || appCubit.upcomingList.isNotEmpty) {
        final data = appCubit.upcomingList;
        return ListView.builder(
            itemCount: data.length + 1,
            itemBuilder: (context, index) {
              if (index < data.length) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppointmentContainer(
                    appData: data[index],
                    button_1_Title: 'Cancel',
                    button_1_type: AppOperations.cancel,
                    onButton_1_Taped: () {
                      Navigator.pushNamed(context, Routes.cancelAppointmetPage,
                          arguments: {
                            "appointment_id": data[index].appointment_id,
                            "cubit": appCubit
                          });
                    },
                    button_2_Title: 'Edit',
                    button_2_type: AppOperations.edit,
                    onButton_2_Taped: () {
                      Map<String, dynamic> map = {
                        'doctor_id': data[index].doctor_ifon.id,
                        'appointment_id': data[index].appointment_id,
                        'isEditing': true
                      };
                      Navigator.pushNamed(
                          context, Routes.dateAndTimeSelectionPage,
                          arguments: map);
                    },
                  ),
                );
              } else if (index >= data.length && data.length == 0) {
                return SizedBox(
                    height: Appdimensions.getHight(200),
                    child: Center(
                        child: Text(
                            'Opps.., you have no upcoming appointments😊')));
              } else
                return const SizedBox();
            });
      } else {
        return SizedBox();
      }
    });
  }
}
