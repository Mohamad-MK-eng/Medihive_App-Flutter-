import 'package:medihive_1_/models/Prescription.dart';

class MedicalReport {
  String date;
  String? clinic_name;
  String? doctor_name;
  String? doctor_speciality;
  String? patient_name;
  String? report_title;
  String? report_content;
  List<Prescription> pres_list = [];
  MedicalReport(
      {required this.date,
      required this.clinic_name,
      required this.doctor_name,
      required this.doctor_speciality,
      required this.report_title,
      required this.report_content,
      required this.pres_list});

  factory MedicalReport.fromJson(jsonData) {
    List? pres_list_entry = jsonData['prescriptions'];
    return MedicalReport(
        date: jsonData['date'],
        clinic_name: jsonData['clinic'],
        doctor_name: jsonData['doctor'],
        doctor_speciality: jsonData['specialty'],
        report_title: jsonData['title'],
        report_content: jsonData['content'],
        pres_list: List<Prescription>.generate(pres_list_entry?.length ?? 0,
            (index) => Prescription.fromJson(pres_list_entry?[index])));
  }
}
