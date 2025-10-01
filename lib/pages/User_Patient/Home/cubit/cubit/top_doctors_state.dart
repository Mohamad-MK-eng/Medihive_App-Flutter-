part of 'top_doctors_cubit.dart';

@immutable
sealed class TopDoctorsState {}

final class TopDoctorsInitial extends TopDoctorsState {}

final class TDoctorsSuccess extends TopDoctorsState {}

final class TDoctorsLoading extends TopDoctorsState {}

final class TDoctorsFailed extends TopDoctorsState {
  String? errorMessage;
  TDoctorsFailed(this.errorMessage);
}
