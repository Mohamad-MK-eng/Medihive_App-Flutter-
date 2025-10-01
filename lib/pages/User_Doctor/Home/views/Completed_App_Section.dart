import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/helper/Snack_Dialog.dart';
import 'package:medihive_1_/models/DoctorAppointment.dart';
import 'package:medihive_1_/pages/User_Doctor/Home/cubit/doctor_appointment_cubit.dart';
import 'package:medihive_1_/pages/User_Doctor/Home/widgets/Completed_App_Card.dart';
import 'package:medihive_1_/shared/loadingIndecator.dart';

class CompletedAppSection extends StatefulWidget {
  CompletedAppSection({required this.formattedDate});
  String formattedDate;
  @override
  State<CompletedAppSection> createState() => _CompletedAppSectionState();
}

class _CompletedAppSectionState extends State<CompletedAppSection> {
  bool _isRefreshing = false;

  late ScrollController _scrollController;

  initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<DoctorAppointmentCubit>().paginateDoctorApp(
              context: context,
              type: 'completed',
              date: widget.formattedDate,
            );
      }
    });
    super.initState();
  }

  Future<void> _onDragDowntoRefresh() async {
    // here to refresh the completed appointment
    setState(() {
      _isRefreshing = true;
    });
    await context.read<DoctorAppointmentCubit>().loadDoctorAppointment(
        context: context,
        type: 'completed',
        date: widget.formattedDate,
        isRefreshing: true);
    setState(() {
      _isRefreshing = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appCubit = context.read<DoctorAppointmentCubit>();
    return BlocBuilder<DoctorAppointmentCubit, DoctorAppointmentState>(
      buildWhen: (previous, current) {
        return current is AppointmentSucess ||
            current is AppointmentLoading ||
            current is AppointmentFailed &&
                ModalRoute.of(context)?.isCurrent == true;
      },
      builder: (context, state) {
        if (state is AppointmentLoading) {
          return const Loadingindecator();
        } else if (state is AppointmentFailed) {
          return Center(
            child: Text(
              state.error!,
              textAlign: TextAlign.center,
            ),
          );
        } else if (state is AppointmentSucess) {
          final data = appCubit.appointment;
          return RefreshIndicator(
            onRefresh: _onDragDowntoRefresh,
            child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
                itemCount: appCubit.hasMoreApp ? data.length + 1 : data.length,
                itemBuilder: (context, index) {
                  if (!_isRefreshing) {
                    if (index < data.length)
                      return CompletedAppCard(appointment: data[index]);
                    else
                      return const SizedBox(
                        height: 50,
                        child: Center(
                            child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: lightBlue,
                        )),
                      );
                  }
                  return null;
                }),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
