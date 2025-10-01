part of 'Clinic_cubit.dart';

@immutable
sealed class ClinicState {}

final class ClinicsInitial extends ClinicState {}

final class ClinicsLoading extends ClinicState {}

final class ClinicsSuccess extends ClinicState {
  ClinicsSuccess();
}

final class ClinicsFailed extends ClinicState {
  String? errorMessage;
  ClinicsFailed(this.errorMessage);
}
