part of 'doctor_cubit.dart';

@immutable
sealed class DoctorState {}

final class DoctorInitial extends DoctorState {}

final class DoctorLoading extends DoctorState {}

final class DoctorFailed extends DoctorState {
  String? errorMessage;
  DoctorFailed(this.errorMessage);
}

final class DoctorsListSuccess extends DoctorState {}

final class DocotrDetailsSuccess extends DoctorState {}
