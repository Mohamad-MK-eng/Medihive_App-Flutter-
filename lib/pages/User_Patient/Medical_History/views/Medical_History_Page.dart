import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/helper/Routes.dart';
import 'package:medihive_1_/models/Clinic.dart';
import 'package:medihive_1_/pages/User_Patient/Home/widgets/Search_Types_Row.dart';
import 'package:medihive_1_/pages/User_Patient/Medical_History/Widgets/Clinic_Filter_DropDown.dart';
import 'package:medihive_1_/pages/User_Patient/Medical_History/Widgets/Medical_History_Container.dart';
import 'package:medihive_1_/pages/User_Patient/Medical_History/Widgets/Month_Picker_Container.dart';
import 'package:medihive_1_/pages/User_Patient/Medical_History/cubit/medical_history_cubit.dart';
import 'package:medihive_1_/shared/loadingIndecator.dart';

class MedicalHistoryPage extends StatefulWidget {
  MedicalHistoryPage({required this.clinics});
  List<Clinic> clinics;
  @override
  State<MedicalHistoryPage> createState() => _MedicalHistoryPageState();
}

class _MedicalHistoryPageState extends State<MedicalHistoryPage> {
  int? selectedHeader;
  int? selected_clinic_id;
  String? selected_date;

  late ScrollController _scrollController;

  onSelectedHeader(int index) {
    setState(() {
      selectedHeader = index;
    });
    context.read<MedicalHistoryCubit>().resetSittingsforFilter();
  }

  onSelectedDate(String? value) {
    setState(() {
      selected_date = value;
      selected_clinic_id = null;
    });
    context.read<MedicalHistoryCubit>().resetSittingsforFilter();
    context.read<MedicalHistoryCubit>().getMedicalHistory(
        context: context, clinic_id: selected_clinic_id, date: selected_date);
  }

  onSlectedClinic(int? value) {
    setState(() {
      selected_clinic_id = value;
      selected_date = null;
    });
    context.read<MedicalHistoryCubit>().resetSittingsforFilter();
    context.read<MedicalHistoryCubit>().getMedicalHistory(
        context: context, clinic_id: selected_clinic_id, date: selected_date);
  }

  @override
  void initState() {
    // TODO: implement initState
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<MedicalHistoryCubit>().getMedicalHistory(
            context: context,
            clinic_id: selected_clinic_id,
            date: selected_date);
      }
    });
    context.read<MedicalHistoryCubit>().getMedicalHistory(
        context: context, clinic_id: selected_clinic_id, date: selected_date);
    super.initState();
  }

  @override
  dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final medHisCubit = context.read<MedicalHistoryCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text('Medical Records')),
      body: Column(
        children: [
          selectedHeader != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    selectedHeader == 1 // clinic drop down
                        ? ClinicFilterDropDown(
                            items: widget.clinics,
                            hintText: 'Select a Clinic!',
                            onSelectedItme: onSlectedClinic)
                        : MonthPickerContainer(onDateSlected: onSelectedDate),
                    // removing filter
                    IconButton(
                        onPressed: () async {
                          setState(() {
                            selectedHeader = null;
                            selected_clinic_id = null;
                            selected_date = null;
                          });
                          medHisCubit.resetSittingsforFilter();
                          Future.delayed(Duration(microseconds: 150), () {
                            medHisCubit.getMedicalHistory(
                                context: context,
                                clinic_id: selected_clinic_id,
                                date: selected_date);
                          });
                        },
                        icon: Icon(
                          Icons.filter_alt_off,
                          color: Colors.red.shade300,
                          size: 30,
                        ))
                  ],
                )
              : const SizedBox(),
          const SizedBox(
            height: 10,
          ),
          SearchTypesRow(
            selecteTypeIndex: selectedHeader,
            onSelectedType: onSelectedHeader,
            firstHeaderName: 'Date',
          ),
          const Divider(
            height: 10,
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
              child: BlocBuilder<MedicalHistoryCubit, MedicalHistoryState>(
            buildWhen: (previous, current) {
              return current is LoadingMH ||
                  current is successMH ||
                  current is FailedMH;
            },
            builder: (context, state) {
              if (state is LoadingMH) {
                return Loadingindecator();
              } else if (state is FailedMH) {
                return Center(
                  child: Text(
                    state.errorMessage!,
                    textAlign: TextAlign.center,
                  ),
                );
              } else if (state is successMH) {
                final data = medHisCubit.data;
                return ListView.builder(
                    controller: _scrollController,
                    itemCount:
                        medHisCubit.hasMore ? data.length + 1 : data.length,
                    itemBuilder: (context, index) {
                      if (index < data.length) {
                        return GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 10, right: 20, left: 20),
                            child: MedicalHistoryContainer(
                                appData: medHisCubit.data[index]),
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.patSelectedRecordPage,
                                arguments: {
                                  "appointment_id":
                                      medHisCubit.data[index].appointment_id,
                                });
                          },
                        );
                      } else if (data.isNotEmpty) {
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
                    });
              } else {
                return const SizedBox();
              }
            },
          )),
        ],
      ),
    );
  }
}
