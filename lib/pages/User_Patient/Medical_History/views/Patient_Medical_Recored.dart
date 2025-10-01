import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/helper/Routes.dart';
import 'package:medihive_1_/pages/User_Patient/Medical_History/Widgets/Prescription_Card.dart';
import 'package:medihive_1_/pages/User_Patient/Medical_History/cubit/medical_history_cubit.dart';
import 'package:medihive_1_/shared/Data_Row.dart';
import 'package:medihive_1_/shared/loadingIndecator.dart';

class PatientMedicalRecored extends StatefulWidget {
  PatientMedicalRecored(
      {required this.appointment_id,
      this.type = 'appointment',
      this.patient_name});
  int appointment_id;
  String? type;
  String? patient_name;
  @override
  State<PatientMedicalRecored> createState() => _PatientMedicalRecoredState();
}

class _PatientMedicalRecoredState extends State<PatientMedicalRecored> {
  bool _isExpanded = false;
  late bool _isfromDoctor;
  Color theme_color = hardmintGreen;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _isExpanded = false;
      _isfromDoctor = widget.patient_name != null;
    });
    if (_isfromDoctor) {
      theme_color = midnigth_bule;
    }

    if (_isfromDoctor) {
      context.read<MedicalHistoryCubit>().getReportForDoctor(
          context: context, id: widget.appointment_id, type: widget.type!);
    } else {
      context.read<MedicalHistoryCubit>().getReportMethod(
          context: context, appointment_id: widget.appointment_id);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final medCubit = context.read<MedicalHistoryCubit>();
    return Scaffold(
      appBar: AppBar(
          title: Text(
        !_isfromDoctor ? 'Medical Report' : widget.patient_name!,
        style: TextStyle(color: theme_color),
      )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: BlocBuilder<MedicalHistoryCubit, MedicalHistoryState>(
          builder: (context, state) {
            if (state is ReportLoading) {
              return const Loadingindecator();
            } else if (state is ReportFailed) {
              return Center(
                child: Text(
                  state.errorMessage!,
                  textAlign: TextAlign.center,
                ),
              );
            } else if (state is ReportSuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CustomDataRow(
                    title1: 'Date',
                    data1: medCubit.report.date,
                    title2: 'Clinic',
                    data2: medCubit.report.clinic_name,
                    titleColor: theme_color,
                  ),
                  CustomDataRow(
                    title1: 'Doctor',
                    data1: medCubit.report.doctor_name ?? '',
                    title2: 'Doctor specility',
                    data2: medCubit.report.doctor_speciality,
                    titleColor: theme_color,
                  ),
                  CustomDataRow(
                    title1: 'Report Title',
                    data1: medCubit.report.report_title ?? '',
                    title2: null,
                    data2: null,
                    titleColor: theme_color,
                  ),
                  CustomDataRow(
                    title1: 'Report',
                    data1: medCubit.report.report_content ?? '',
                    title2: null,
                    data2: null,
                    titleColor: theme_color,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'Prescription',
                        style: TextStyle(
                            color: theme_color,
                            fontSize: 16,
                            fontFamily: 'Arial',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 2),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _isExpanded = !_isExpanded;
                            });
                          },
                          icon: Icon(_isExpanded
                              ? Icons.keyboard_arrow_down_outlined
                              : Icons.keyboard_arrow_up)),
                      const Expanded(child: SizedBox()),
                      TextButton(
                          onPressed: () {
                            if (medCubit.report.pres_list.isNotEmpty) {
                              Navigator.pushNamed(
                                  context, Routes.prescriptionPage,
                                  arguments: medCubit.report.pres_list);
                            }
                          },
                          child: Text(
                            "See All",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color:
                                  _isfromDoctor ? hardmintGreen : midnigth_bule,
                              fontSize: 15,
                            ),
                          ))
                    ],
                  ),
                  _isExpanded
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: medCubit.report.pres_list.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final data = medCubit.report.pres_list;
                              if (data.isEmpty) {
                                return const SizedBox(
                                  height: 200,
                                  child: Center(
                                    child: Text(
                                      'No Prescription has been added!',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              } else {
                                return PrescriptionCard(
                                  presInfo: data[index],
                                  index: index + 1,
                                );
                              }
                            },
                          ),
                        )
                      : SizedBox(),
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
}
