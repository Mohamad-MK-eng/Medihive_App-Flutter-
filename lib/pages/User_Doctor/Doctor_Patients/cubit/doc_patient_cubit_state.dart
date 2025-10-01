part of 'doc_patient_cubit_cubit.dart';

@immutable
sealed class DocPatientState {}

final class DocPatientInitial extends DocPatientState {}

final class PatientsSuccess extends DocPatientState {}

final class PatientsInitial extends DocPatientState {}

final class PatientsLoading extends DocPatientState {}

final class PatientsFailed extends DocPatientState {
  String? errorMessage;
  PatientsFailed(this.errorMessage);
}

final class ReportsSuccess extends DocPatientState {}

final class ReportsIni extends DocPatientState {}

final class ReportsLoading extends DocPatientState {}

final class ReportsFailed extends DocPatientState {
  String? errorMessage;
  ReportsFailed(this.errorMessage);
}
