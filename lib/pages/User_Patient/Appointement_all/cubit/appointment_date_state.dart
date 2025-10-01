part of 'appointment_date_cubit.dart';

@immutable
sealed class AppointmentDateState {}

final class AppointmentDateInitial extends AppointmentDateState {}

final class AppointmentDaysloading extends AppointmentDateState {}

final class AppointmentDaysSuccess extends AppointmentDateState {}

final class AppointmentDaysFailed extends AppointmentDateState {
  String? errorMessage;
  AppointmentDaysFailed(this.errorMessage);
}

final class AppointmentTimesloading extends AppointmentDateState {}

final class AppointmentTimesSuccess extends AppointmentDateState {}

final class AppointmentTimesFailed extends AppointmentDateState {
  String? errorMessage;
  AppointmentTimesFailed(this.errorMessage);
}

final class AppointmentTimesReset extends AppointmentDateState {}

final class EditSuccess extends AppointmentDateState {}

final class EditLoading extends AppointmentDateState {}

final class EditFailed extends AppointmentDateState {
  String? errorMessage;
  EditFailed(this.errorMessage);
}
