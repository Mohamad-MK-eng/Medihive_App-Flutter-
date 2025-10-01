import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/helper/Snack_Dialog.dart';
import 'package:medihive_1_/models/DoctorAppointment.dart';
import 'package:medihive_1_/models/Prescription.dart';
import 'package:medihive_1_/pages/User_Doctor/Home/cubit/doctor_appointment_cubit.dart';
import 'package:medihive_1_/pages/User_Patient/Medical_History/Widgets/Prescription_Card.dart';
import 'package:medihive_1_/shared/Custom_Button.dart';
import 'package:medihive_1_/shared/Custom_TextFormField.dart';
import 'package:medihive_1_/shared/Data_Row.dart';
import 'package:medihive_1_/shared/loadingIndecator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AddReportPage extends StatefulWidget {
  AddReportPage({required this.appointment, required this.appointment_index});
  Doctorappointment appointment;
  int appointment_index;
  @override
  State<AddReportPage> createState() => _AddReportPageState();
}

class _AddReportPageState extends State<AddReportPage> {
  String title = '';
  String content = '';
  FocusNode _titlNode = FocusNode();
  FocusNode _contentNode = FocusNode();

  // قائمة الأدوية
  final List<Prescription> _drugs = [];
  bool _isLoading = false;
  bool _isSuccess = false;

  // controllers للحقول (تم نقلهم إلى هنا)
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _doseCtrl = TextEditingController();
  final TextEditingController _freqCtrl = TextEditingController();
  final TextEditingController _noteCtrl = TextEditingController();

  @override
  void dispose() {
    _titlNode.dispose();
    _contentNode.dispose();
    _nameCtrl.dispose();
    _doseCtrl.dispose();
    _freqCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  Future<void> _openAddDrugSheet() async {
    _nameCtrl.clear();
    _doseCtrl.clear();
    _freqCtrl.clear();
    _noteCtrl.clear();

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Add Medication",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                TextField(
                    controller: _nameCtrl,
                    decoration: const InputDecoration(labelText: "Drug Name")),
                TextField(
                    controller: _doseCtrl,
                    decoration: const InputDecoration(labelText: "Dosage")),
                TextField(
                    controller: _freqCtrl,
                    decoration: const InputDecoration(labelText: "Frequency")),
                TextField(
                    controller: _noteCtrl,
                    decoration: const InputDecoration(labelText: "Notes")),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // إضافة دواء للقائمة
                        if (_nameCtrl.text.trim().isEmpty &&
                            _doseCtrl.text.trim().isEmpty) return;

                        setState(() {
                          _drugs.add(Prescription(
                              drug: _nameCtrl.text,
                              dose: _doseCtrl.text,
                              repeate: _freqCtrl.text,
                              notes: _noteCtrl.text));
                        });

                        _nameCtrl.clear();
                        _doseCtrl.clear();
                        _freqCtrl.clear();
                        _noteCtrl.clear();
                      },
                      child: const Text("Add +"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        Navigator.pop(context);
                      },
                      child: const Text("Finish"),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: midnigth_bule,
        foregroundColor: Colors.white,
        title: const Text(
          'Medical Report',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocListener<DoctorAppointmentCubit, DoctorAppointmentState>(
        listenWhen: (previous, current) {
          return current is ReportSuccess ||
              current is ReportLoading ||
              current is ReportFailed &&
                  ModalRoute.of(context)?.isCurrent == true;
        },
        listener: (context, state) {
          if (state is ReportLoading) {
            setState(() {
              _isLoading = true;
            });
          } else if (state is ReportFailed) {
            showErrorSnackBar(context, state.error);
            setState(() {
              _isLoading = false;
            });
          } else if (state is ReportSuccess) {
            setState(() {
              _isLoading = false;
              _isSuccess = true;
            });
            showSuccessSnackBar(context, 'Medical Report Added Successfully');
          }
        },
        child: ModalProgressHUD(
          inAsyncCall: _isLoading,
          progressIndicator: Loadingindecator(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomDataRow(
                  title1: 'Patient Name',
                  data1: widget.appointment.patientName,
                  title2: null,
                  data2: null,
                  titleColor: midnigth_bule,
                ),
                CustomDataRow(
                  title1: 'Time',
                  data1: widget.appointment.time,
                  title2: 'Date',
                  data2: widget.appointment.date,
                  titleColor: midnigth_bule,
                ),
                const SizedBox(height: 5),
                CustomeTextFormField(
                  onChanged: (data) {
                    title = data;
                  },
                  focusNode: _titlNode,
                  title: 'Report Title',
                  title_color: midnigth_bule,
                  strok_color: hardGrey,
                  hintText: 'Submit a title for this Report',
                  maxLines: 2,
                ),
                const SizedBox(height: 5),
                CustomeTextFormField(
                  onChanged: (data) {
                    content = data;
                  },
                  focusNode: _contentNode,
                  title: 'Report Content',
                  title_color: midnigth_bule,
                  strok_color: hardGrey,
                  hintText: 'Submit the Content of this Report',
                  maxLines: 3,
                ),
                const SizedBox(height: 15),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Prescription',
                        style: TextStyle(
                            color: midnigth_bule,
                            fontSize: 16,
                            fontFamily: 'Arial',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 2),
                      ),
                      InkWell(
                        onTap: _openAddDrugSheet,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 6),
                          decoration: BoxDecoration(
                            color: mintGreen.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Add Medication +',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ]),
                const SizedBox(height: 10),
                Column(
                  children: List.generate(_drugs.length, (index) {
                    final drug = _drugs[index];
                    return PrescriptionCard(
                      presInfo: drug,
                      index: index + 1,
                      onDelete: () {
                        _removeDrug(index);
                      },
                    );
                  }),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: CustomButton(
                    buttonText: ' Save Report ',
                    onTap: () async {
                      if (_checkBeforApi()) {
                        if (!_isSuccess) {
                          context
                              .read<DoctorAppointmentCubit>()
                              .addMedicalReport(
                                  context: context,
                                  appointment_id:
                                      widget.appointment.appointmentId,
                                  title: title,
                                  content: content,
                                  index: widget.appointment_index,
                                  presData: _drugs);
                        }
                      } else {
                        showErrorSnackBar(
                            context, 'the report Title is required!');
                      }
                    },
                    enableSaveIcon: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // حذف دواء
  void _removeDrug(int index) {
    setState(() => _drugs.removeAt(index));
  }

  bool _checkBeforApi() {
    if (title.trim().isEmpty && content.trim().isEmpty && _drugs.isEmpty)
      return false;
    return true;
  }
}
