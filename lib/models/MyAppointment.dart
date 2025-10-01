import 'package:medihive_1_/models/Doctor.dart';

class Myappointment {
  Doctor doctor_ifon;
  int appointment_id;
  String full_date;
  String clinic_name;
  int? last_page;

  String? app_state;

  Myappointment(
      {required this.doctor_ifon,
      required this.appointment_id,
      required this.full_date,
      required this.app_state,
      required this.clinic_name,
      this.last_page});
  factory Myappointment.fromJson({required jsonData, int? page}) {
    return Myappointment(
        doctor_ifon: Doctor.lightJson(jsonData),
        appointment_id: jsonData['id'],
        full_date: jsonData['date'],
        clinic_name: jsonData['clinic_name'],
        app_state: jsonData['type'],
        last_page: page);
  }
}

enum AppOperations { cancel, edit, rebook, rate }
