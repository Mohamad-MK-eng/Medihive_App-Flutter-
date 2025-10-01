part of 'doctor_appointment_cubit.dart';

@immutable
sealed class DoctorAppointmentState {}

final class DoctorAppointmentInitial extends DoctorAppointmentState {}

final class AppointmentSucess extends DoctorAppointmentState {}

final class AppointmentLoading extends DoctorAppointmentState {}

final class AppointmentFailed extends DoctorAppointmentState {
  String? error;
  AppointmentFailed(this.error);
}

final class AbsentSuccess extends DoctorAppointmentState {
  String SuccessMessage;
  int data_index;
  AbsentSuccess({required this.SuccessMessage, required this.data_index});
}

final class AbsentFailed extends DoctorAppointmentState {
  String? apiMessage;
  String? errorMessage;
  int appointment_id;
  String patinet_name;
  int index;
  AbsentFailed(
      {required this.appointment_id,
      this.apiMessage,
      this.errorMessage,
      required this.index,
      required this.patinet_name});
}

final class CompletedSucces extends DoctorAppointmentState {
  String message;
  CompletedSucces({required this.message});
}

final class CompletedFailed extends DoctorAppointmentState {
  Doctorappointment appointment;
  int data_index;
  String? error;
  CompletedFailed(
      {required this.appointment, required this.data_index, this.error});
}

final class CancelSucces extends DoctorAppointmentState {}

final class CancelFailed extends DoctorAppointmentState {
  List<int> appointments_ids;
  List<int> data_index;
  String reason;
  String error;
  CancelFailed(
      {required this.appointments_ids,
      required this.data_index,
      required this.reason,
      required this.error});
}

final class ReportSuccess extends DoctorAppointmentState {}

final class ReportLoading extends DoctorAppointmentState {}

final class ReportFailed extends DoctorAppointmentState {
  String error;
  ReportFailed({required this.error});
}
