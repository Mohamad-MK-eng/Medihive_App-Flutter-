import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/constant/AppDimensions.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/helper/Custom_Dialog.dart';
import 'package:medihive_1_/pages/User_Patient/Appointement_all/cubit/my_appointment_cubit.dart';
import 'package:medihive_1_/shared/Custom_Button.dart';
import 'package:medihive_1_/shared/loadingIndecator.dart';

class CancelAppointmentPage extends StatefulWidget {
  CancelAppointmentPage({required this.appointment_id});
  int appointment_id;

  @override
  State<CancelAppointmentPage> createState() => _CancelAppointmentPageState();
}

class _CancelAppointmentPageState extends State<CancelAppointmentPage> {
  @override
  void dispose() {
    super.dispose();
  }

  List<String> reasons = [
    'Rescheduling',
    'Feeling Better',
    'Weather condition',
    'Financial constraints',
    'Un expected work',
    'Bad Service',
    'Other reasons'
  ];

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //    resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text('Cancel Appointment'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocBuilder<MyAppointmentCubit, MyAppointmentState>(
            buildWhen: (previous, current) {
              return current is CancelFailed ||
                  current is CancelLoading ||
                  current is CancelSuccess;
            },
            builder: (context, state) {
              if (state is CancelLoading) {
                return const Loadingindecator();
              } else if (state is CancelFailed) {
                return Center(
                  child: Text(state.errorMessage!),
                );
              } else if (state is CancelSuccess) {
                /* context.read<MyAppointmentCubit>().upcomingList.removeWhere(
                    (item) => item.appointment_id == widget.appointment_id); */
                context
                    .read<MyAppointmentCubit>()
                    .getUpcomingAppMethod(context: context);
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: Appdimensions.getWidth(60),
                      ),
                      Icon(
                        Icons.check_circle,
                        size: Appdimensions.getHight(150),
                        color: hardmintGreen,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Operation Done Succesfluy',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFF003692),
                            fontSize: 22,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Arial',
                            fontWeight: FontWeight.w600,
                            height: 0.33,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'contnetn about cancelation???',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: geryinAuthTextField,
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ]);
              } else
                return Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                          reasons.length,
                          (index) => CheckboxListTile(
                              title: Text(reasons[index]),
                              activeColor: hardmintGreen,
                              checkboxShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              checkColor: hardmintGreen,
                              controlAffinity: ListTileControlAffinity.leading,
                              value: index == selectedIndex,
                              onChanged: (value) {
                                selectedIndex = index;
                                setState(() {});
                              })),
                    ),
                    Expanded(child: const SizedBox()),
                    selectedIndex != null
                        ? SizedBox(
                            height: Appdimensions.getHight(125),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: CustomButton(
                                  buttonText: 'Cancel Appointment',
                                  onTap: () async {
                                    if (selectedIndex != null) {
                                      {
                                        showCustomDialog(
                                          context: context,
                                          type: CustomDialogType.warning,
                                          title: 'Confirming required!',
                                          content:
                                              "By completing this operation your appointment will be canceld ! funds???",
                                          onConfirm: () {
                                            context
                                                .read<MyAppointmentCubit>()
                                                .cancelAppointmentMethod(
                                                    context: context,
                                                    reason:
                                                        reasons[selectedIndex!],
                                                    appointment_id:
                                                        widget.appointment_id);
                                          },
                                        );
                                      }
                                    }
                                  }),
                            ),
                          )
                        : const SizedBox()
                  ],
                );
            },
          ),
          /*   Expanded(child: const SizedBox()),
              selectedIndex != null
                  ? SizedBox(
                      height: Appdimensions.getHight(125),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: CustomButton(
                            buttonText: 'Cancel Appointment',
                            onTap: () async {
                              if (selectedIndex != null) {
                                {
                                  showCustomDialog(
                                    context: context,
                                    type: CustomDialogType.warning,
                                    title: 'Confirming required!',
                                    content:
                                        "By completing this operation your appointment will be canceld ! funds???",
                                    onConfirm: () {
                                      context
                                          .read<MyAppointmentCubit>()
                                          .cancelAppointmentMethod(
                                              context: context,
                                              reason: reasons[selectedIndex!],
                                              appointment_id:
                                                  widget.appointment_id);
                                    },
                                  );
                                }
                              }
                            }),
                      ),
                    )
                  : const SizedBox() */
        ));
  }
}
