part of 'medical_history_cubit.dart';

@immutable
sealed class MedicalHistoryState {}

final class MedicalHistoryInitial extends MedicalHistoryState {}

final class successMH extends MedicalHistoryState {}

final class FailedMH extends MedicalHistoryState {
  String? errorMessage;
  FailedMH(this.errorMessage);
}

final class LoadingMH extends MedicalHistoryState {}

final class ReportSuccess extends MedicalHistoryState {}

final class ReportLoading extends MedicalHistoryState {}

final class ReportFailed extends MedicalHistoryState {
  String? errorMessage;
  ReportFailed(this.errorMessage);
}
