part of 'search_cubit.dart';

@immutable
sealed class PatientSearchStates {}

final class SearchInitial extends PatientSearchStates {}

final class PSearchClinicLoading extends PatientSearchStates {}

final class PSearchDoctorLoading extends PatientSearchStates {}

final class PSearchClinicSuccess extends PatientSearchStates {}

final class PSearchDoctorSuccess extends PatientSearchStates {}

final class PSearchClinicFailed extends PatientSearchStates {
  String? errorMessage;
  PSearchClinicFailed(this.errorMessage);
}

final class PatientSearchIni extends PatientSearchStates {}

final class PSearchDoctorFailed extends PatientSearchStates {
  String? errorMessage;
  PSearchDoctorFailed(this.errorMessage);
}
