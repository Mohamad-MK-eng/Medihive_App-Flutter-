part of 'my_appointment_cubit.dart';

@immutable
sealed class MyAppointmentState {}

final class MyAppointmentInitial extends MyAppointmentState {}

final class UpcomingSuccess extends MyAppointmentState {}

final class UpcomingLoading extends MyAppointmentState {}

final class UpcomingFailed extends MyAppointmentState {
  String? errorMessage;
  UpcomingFailed(this.errorMessage);
}

final class CompletedSuccess extends MyAppointmentState {}

final class CompletedLoading extends MyAppointmentState {}

final class CompletedFailed extends MyAppointmentState {
  String? errorMessage;
  CompletedFailed(this.errorMessage);
}

final class AbsentSuccess extends MyAppointmentState {}

final class AbsentLoading extends MyAppointmentState {}

final class AbsentFailed extends MyAppointmentState {
  String? errorMessage;
  AbsentFailed(this.errorMessage);
}

final class PagCompletedSuccess extends MyAppointmentState {}

final class PagCompletedLoading extends MyAppointmentState {}

final class PagCompletedFailed extends MyAppointmentState {
  String? errorMessage;
  PagCompletedFailed(this.errorMessage);
}

final class CancelSuccess extends MyAppointmentState {}

final class CancelLoading extends MyAppointmentState {}

final class CancelFailed extends MyAppointmentState {
  String? errorMessage;
  CancelFailed(this.errorMessage);
}

final class RateInitila extends MyAppointmentState {}

final class RateSuccess extends MyAppointmentState {}

final class RateLoading extends MyAppointmentState {}

final class RateFailed extends MyAppointmentState {
  String? errorMessage;
  RateFailed(this.errorMessage);
}
