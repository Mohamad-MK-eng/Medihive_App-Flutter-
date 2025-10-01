part of 'auth_cubit_cubit.dart';

@immutable
sealed class AuthCubitState {}

// log in states
final class AuthCubitInitial extends AuthCubitState {}

final class SuccessAuth extends AuthCubitState {}

final class LoadingAuth extends AuthCubitState {}

final class FailedAuth extends AuthCubitState {
  final String error;
  FailedAuth(this.error);
}

final class SuccessReset extends AuthCubitState {}

final class LoadingReset extends AuthCubitState {}

final class FailedReset extends AuthCubitState {
  final String error;
  FailedReset(this.error);
}

final class SendCodeSuccess extends AuthCubitState {}

final class SendCodeFailed extends AuthCubitState {
  String error;
  SendCodeFailed({required this.error});
}
