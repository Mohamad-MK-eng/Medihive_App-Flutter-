import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/pages/User_Patient/Appointement_all/cubit/my_appointment_cubit.dart';
import 'package:medihive_1_/pages/User_Patient/Appointement_all/widgets/Absent_App_Cont.dart';
import 'package:medihive_1_/shared/loadingIndecator.dart';

import '../../../../constant/Colors&Fonts.dart';

class AbsentSection extends StatefulWidget {
  const AbsentSection({super.key});

  @override
  State<AbsentSection> createState() => _AbsentSectionState();
}

class _AbsentSectionState extends State<AbsentSection> {
  @override
  late ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<MyAppointmentCubit>().getAbsentApp(context: context);
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

    if (appCubit.absentList.isEmpty) {
      appCubit.getAbsentApp(context: context);
    }

    return BlocBuilder<MyAppointmentCubit, MyAppointmentState>(
        buildWhen: (previous, current) {
      return current is AbsentSuccess ||
          current is AbsentFailed ||
          current is AbsentLoading;
    }, builder: (context, state) {
      if (state is AbsentLoading) {
        return const Loadingindecator();
      } else if (state is AbsentFailed) {
        return Center(
          child: Text(
            state.errorMessage!,
            textAlign: TextAlign.center,
          ),
        );
      } else if (state is AbsentSuccess || appCubit.absentList.isNotEmpty) {
        final data = appCubit.absentList;
        return ListView.builder(
            itemCount: appCubit.hasMoreAbs ? data.length + 1 : data.length,
            controller: _scrollController,
            itemBuilder: (context, index) {
              if (index < data.length) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AbsentAppCont(appData: data[index]),
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
