import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/pages/User_Doctor/Doctor_Patients/Widgets/Pat_Records_Container.dart';

import 'package:medihive_1_/pages/User_Doctor/Doctor_Patients/cubit/doc_patient_cubit_cubit.dart';
import 'package:medihive_1_/shared/loadingIndecator.dart';

class PatientsRecordsPage extends StatefulWidget {
  PatientsRecordsPage({required this.patient_id, required this.patient_name});
  int patient_id;
  String patient_name;
  @override
  State<PatientsRecordsPage> createState() => _PatientsRecordsPageState();
}

class _PatientsRecordsPageState extends State<PatientsRecordsPage> {
  DateTime _currentDate = DateTime.now();

  void _navigateMonth(int offset) {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month + offset);
    });
    context.read<DocPatientCubit>().loadPatRecords(
        context: context,
        patient_id: widget.patient_id,
        month: DateFormat('MM').format(_currentDate),
        year: DateFormat('yyyy').format(_currentDate));
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    context.read<DocPatientCubit>().loadPatRecords(
        context: context,
        patient_id: widget.patient_id,
        month: DateFormat('MM').format(_currentDate),
        year: DateFormat('yyyy').format(_currentDate));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _formattedDate = DateFormat('yyyy-MM').format(_currentDate);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: _getAppBar(_formattedDate, context),
        body: BlocBuilder<DocPatientCubit, DocPatientState>(
          builder: (context, state) {
            if (state is ReportsLoading) {
              return const Loadingindecator();
            } else if (state is ReportsFailed) {
              return Center(
                  child: Text(
                state.errorMessage!,
                textAlign: TextAlign.center,
              ));
            } else if (state is ReportsSuccess) {
              final data = context.read<DocPatientCubit>().patRecords;
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        widget.patient_name,
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: jomalhiriFont,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                child: PatRecordsContainer(
                                  record: data[index],
                                  patinet_name: widget.patient_name,
                                ));
                          }),
                    ),
                  ]);
            } else
              return const SizedBox();
          },
        ));
  }

  AppBar _getAppBar(String _formattedDate, BuildContext context) {
    return AppBar(
      backgroundColor: midnigth_bule,
      foregroundColor: Colors.white,
      title: Text(
        _formattedDate,
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        IconButton(
            onPressed: () {
              _navigateMonth(-1);
            },
            icon: Icon(
              Icons.chevron_left,
              size: 40,
            )),
        IconButton(
            onPressed: () {
              _navigateMonth(1);
            },
            icon: const Icon(
              Icons.chevron_right,
              size: 40,
            )),
        IconButton(
            onPressed: () async {
              final _datePicked = await showDatePicker(
                context: context,
                initialDate: _currentDate,
                firstDate: DateTime(2025),
                lastDate: DateTime(2026),
              );
              if (_datePicked != null) {
                setState(() {
                  _currentDate = _datePicked;
                });
              }
              _navigateMonth(0);
            },
            icon: const Icon(
              Icons.calendar_month,
              size: 30,
            )),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }
}
