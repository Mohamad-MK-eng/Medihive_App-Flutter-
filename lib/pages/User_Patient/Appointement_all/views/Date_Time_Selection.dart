import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/constant/AppDimensions.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/helper/Routes.dart';
import 'package:medihive_1_/helper/Snack_Dialog.dart';
import 'package:medihive_1_/models/Arguments_Models/final_docot_payment_date_info.dart';
import 'package:medihive_1_/pages/User_Patient/Appointement_all/cubit/appointment_date_cubit.dart';
import 'package:medihive_1_/pages/User_Patient/Appointement_all/widgets/DayContainer.dart';
import 'package:medihive_1_/pages/User_Patient/Appointement_all/widgets/TimeContainer.dart';
import 'package:medihive_1_/pages/User_Patient/Appointement_all/widgets/earliest_date.dart';
import 'package:medihive_1_/shared/Custom_Button.dart';
import 'package:medihive_1_/shared/loadingIndecator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class DateTimeSelection extends StatefulWidget {
  DateTimeSelection({required this.doctorId_doctorFee});
  Map<String, dynamic> doctorId_doctorFee;

  @override
  State<DateTimeSelection> createState() => _DateTimeSelectionState();
}

class _DateTimeSelectionState extends State<DateTimeSelection> {
  int? selectedDayIndex; // لتخزين اليوم المحدد
  int? selectedTimeIndex; // لتخزين اليوم المحدد
  bool isEarliest_date_selected = false;
  String? dateSelectedData;
  int? timeSelectedData;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int doctor_id = widget.doctorId_doctorFee['doctor_id'];
    String? doctorFee = widget.doctorId_doctorFee['doctor_fee'];
    //   int? appointment_id = widget.doctorId_doctorFee['appointment_id'];
    bool? isEditing = widget.doctorId_doctorFee['isEditing'];
    int? appointment_id = widget.doctorId_doctorFee['appointment_id'];
    bool isEditingLoading = false;
    final appCubit = BlocProvider.of<AppointmentDateCubit>(context);
    if (appCubit.days.isEmpty) {
      appCubit.getAppDaysMethod(context, doctor_id);
    }
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text('Select Date And Time'),
        ),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: ModalProgressHUD(
                  inAsyncCall: isEditingLoading,
                  progressIndicator: Loadingindecator(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Appdimensions.getHight(50),
                          width: double.infinity,
                        ),
                        SizedBox(
                          height: Appdimensions.getHight(110),
                          child: BlocConsumer<AppointmentDateCubit,
                              AppointmentDateState>(
                            listenWhen: (previous, current) {
                              return current is EditLoading ||
                                  current is EditFailed ||
                                  current is EditSuccess;
                            },
                            listener: (context, state) {
                              if (state is EditLoading) {
                                setState(() {
                                  isEditingLoading = true;
                                });
                              } else if (state is EditFailed) {
                                setState(() {
                                  isEditingLoading = false;
                                });
                                showErrorSnackBar(context, state.errorMessage!);
                              } else if (state is EditSuccess) {
                                setState(() {
                                  isEditingLoading = false;
                                });
                                Navigator.pushNamed(
                                    context, Routes.appConfirmationPage,
                                    arguments: appCubit.editedAppInfo);
                              }
                            },
                            buildWhen: (previous, current) {
                              return current is AppointmentDaysSuccess ||
                                  current is AppointmentDaysFailed ||
                                  true;
                            },
                            builder: (context, state) {
                              if (state is AppointmentDaysloading) {
                                return const Loadingindecator();
                              } else if (state is AppointmentDaysFailed) {
                                return Center(
                                  child: Text(
                                      state.errorMessage ?? 'Nothing Found'),
                                );
                              } else if (state is AppointmentDaysSuccess ||
                                  appCubit.days.isNotEmpty) {
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  clipBehavior: Clip.none,
                                  itemCount: appCubit.days.length,
                                  itemBuilder: (context, index) {
                                    final day = appCubit.days[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 30),
                                      child: GestureDetector(
                                        onTap: () {
                                          appCubit.getAppTimesMethod(
                                              context, doctor_id, day.fullDate);

                                          setState(() {
                                            selectedDayIndex = index;
                                            selectedTimeIndex = null;
                                            isEarliest_date_selected = false;
                                            dateSelectedData = day.fullDate;
                                            timeSelectedData =
                                                null; // day.fullDate//  // غيّر اليوم المحدد
                                          });
                                        },
                                        child: Daycontainer(
                                          month: day
                                              .month_name, // days[index].month_name,
                                          day_number: day
                                              .day_number, // days[index].day_number,

                                          day: day
                                              .day_name, // days[index].day_name,
                                          isSelcted: selectedDayIndex ==
                                                  index &&
                                              !isEarliest_date_selected, // تحقق إذا محدد
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: Appdimensions.getHight(55),
                        ),
                        BlocBuilder<AppointmentDateCubit, AppointmentDateState>(
                          // هونا ما قي build when
                          builder: (context, state) {
                            if (state is AppointmentTimesloading) {
                              return const Loadingindecator();
                            } else if (state is AppointmentTimesFailed) {
                              return Center(
                                child: Text(state.errorMessage ??
                                    'There is no times available in this day!'),
                              );
                            } else if (state is AppointmentTimesSuccess) {
                              return Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ' Available Times',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 24,
                                        fontFamily: 'Jomolhari',
                                        fontWeight: FontWeight.w400,
                                        height: 0.50,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Appdimensions.getHight(30),
                                    ),
                                    Flexible(
                                        child: GridView.builder(
                                            clipBehavior: Clip.none,
                                            itemCount: appCubit.times.length,
                                            shrinkWrap: true,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    childAspectRatio: 3,
                                                    crossAxisSpacing: 15,
                                                    mainAxisSpacing: 15,
                                                    crossAxisCount: 3),
                                            itemBuilder: (context, index) {
                                              final time =
                                                  appCubit.times[index];
                                              return GestureDetector(
                                                child: Timecontainer(
                                                    time: time.time,
                                                    isSelected: selectedTimeIndex ==
                                                            index &&
                                                        !isEarliest_date_selected),
                                                onTap: () {
                                                  setState(() {
                                                    selectedTimeIndex = index;
                                                    isEarliest_date_selected =
                                                        false;
                                                    timeSelectedData = time
                                                        .slot_id; //time.time
                                                  });
                                                },
                                              );
                                            })),
                                  ],
                                ),
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                        Divider(
                          height: Appdimensions.getHight(45),
                        ),
                        const Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            'The Earliest Available Date',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: jomalhiriFont,
                              fontWeight: FontWeight.w400,
                              height: 0.60,
                              letterSpacing: 0.60,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        BlocBuilder<AppointmentDateCubit, AppointmentDateState>(
                          buildWhen: (previous, current) {
                            return current is AppointmentDaysSuccess ||
                                current is AppointmentDaysFailed;
                          },
                          builder: (context, state) {
                            if (state is AppointmentDaysSuccess &&
                                appCubit.earliest_date != null) {
                              final fullDateTime = appCubit.earliest_date;
                              return Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  child: EarliestDateContainer(
                                    full_day:
                                        '${fullDateTime!.date.day_name} ${fullDateTime.date.day_number} ${fullDateTime.date.month_name}',
                                    time: fullDateTime.time.time,
                                    isSelected: isEarliest_date_selected,
                                  ),
                                  onTap: () {
                                    appCubit.resetTimes();
                                    setState(() {
                                      isEarliest_date_selected = true;

                                      dateSelectedData =
                                          fullDateTime.date.fullDate;
                                      // fullDateTime.date.fullDate;
                                      timeSelectedData =
                                          fullDateTime.time.slot_id;
                                      //  fullDateTime.time.time;
                                    });
                                  },
                                ),
                              );
                            } else
                              return const SizedBox();
                          },
                        ),
                        Expanded(
                          child: SizedBox(
                              // height: Appdimensions.getHight(300),
                              ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: CustomButton(
                            buttonText: isEditing != null && isEditing
                                ? 'Edit Appointment'
                                : 'Set Appointment',
                            onTap: () async {
                              if (validateData(context)) {
                                if (isEditing != null && isEditing == true) {
                                  appCubit.updateAppointmentMethod(
                                      context: context,
                                      doctor_id: doctor_id,
                                      time_slot_id: timeSelectedData!,
                                      appointment_id: appointment_id!);
                                  return;
                                } else {
                                  Navigator.pushNamed(
                                      context, Routes.paymentPage,
                                      arguments: FinalDocotPaymentDateInfo(
                                          doctor_id: doctor_id,
                                          doctor_fee: doctorFee!,
                                          full_date: dateSelectedData!,
                                          slot_id: timeSelectedData!));
                                }
                              }
                            },
                            isFontBig: false,
                            isWideButtons: true,
                          ),
                        ),
                        SizedBox(
                          height: Appdimensions.getHight(50),
                        )
                      ]),
                ))));
  }

  bool validateData(BuildContext context) {
    if (dateSelectedData == null && timeSelectedData == null) {
      showErrorSnackBar(context, 'Please choose day and time!');
      return false;
    } else if (dateSelectedData != null && timeSelectedData == null) {
      showErrorSnackBar(context, 'Please select time!');
      return false;
    } else if (dateSelectedData == null && timeSelectedData != null) {
      showErrorSnackBar(context, 'Please select time!');
      return false;
    } else {
      return true;
    }
  }
}
