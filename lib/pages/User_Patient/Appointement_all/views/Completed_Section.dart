import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/helper/Routes.dart';
import 'package:medihive_1_/models/MyAppointment.dart';
import 'package:medihive_1_/pages/User_Patient/Appointement_all/cubit/my_appointment_cubit.dart';
import 'package:medihive_1_/pages/User_Patient/Appointement_all/widgets/Appointment_Container.dart';
import 'package:medihive_1_/pages/User_Patient/Appointement_all/widgets/Rate_Custome_Dialog.dart';
import 'package:medihive_1_/shared/loadingIndecator.dart';

class CompletedSection extends StatefulWidget {
  CompletedSection({super.key});
  @override
  State<CompletedSection> createState() => _CompletedSectionState();
}

class _CompletedSectionState extends State<CompletedSection> {
  late ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context
            .read<MyAppointmentCubit>()
            .getCompletedAppMethod(context: context, isPaginating: true);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appCubit = context.read<MyAppointmentCubit>();

    if (appCubit.completedList.isEmpty) {
      appCubit.getCompletedAppMethod(context: context);
    }

    return BlocBuilder<MyAppointmentCubit, MyAppointmentState>(
        buildWhen: (previous, current) {
      return current is CompletedLoading ||
          current is CompletedFailed ||
          current is CompletedSuccess ||
          current is PagCompletedSuccess;
    }, builder: (context, state) {
      if (state is CompletedLoading) {
        return const Loadingindecator();
      } else if (state is CompletedFailed) {
        return Center(
          child: Text(state.errorMessage!),
        );
      } else if (state is CompletedSuccess ||
          state is PagCompletedSuccess ||
          appCubit.completedList.isNotEmpty) {
        final data = appCubit.completedList;
        return ListView.builder(
            itemCount: appCubit.hasMoreCom ? data.length + 1 : data.length,
            controller: _scrollController,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if (index < data.length) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppointmentContainer(
                    appData: data[index],
                    button_1_Title: 'Rebook',
                    button_1_type: AppOperations.rebook,
                    onButton_1_Taped: () {
                      Navigator.pushNamed(context, Routes.doctorDetailsPage,
                          arguments: data[index].doctor_ifon);
                    },
                    button_2_Title: 'Rate',
                    button_2_type: AppOperations.rate,
                    onButton_2_Taped: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return BlocProvider.value(
                              value: appCubit,
                              child: RateCustomDialog(
                                appointment_id: data[index].appointment_id,
                                rate_cubit: appCubit,
                              ),
                            );
                          });
                    },
                  ),
                );
              } else {
                return const SizedBox(
                  height: 50,
                  child: Center(
                      child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: lightBlue,
                  )),
                );
              }
            });
      } else {
        return const SizedBox();
      }
    });
  }
}
