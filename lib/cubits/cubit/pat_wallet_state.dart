part of 'pat_wallet_cubit.dart';

@immutable
sealed class PatWalletState {}

final class PatWalletInitial extends PatWalletState {}

// حالات الفشل

final class WalletNotActivated extends PatWalletState {
  String? errorMessage;
  WalletNotActivated(this.errorMessage);
}

final class BookingFailed extends PatWalletState {
  String? errorMessage;
  BookingFailed(this.errorMessage);
}

// حالة load لعملية الدقع
final class BookingLoading extends PatWalletState {}

// نجاح الحجز
final class BookingSuccess extends PatWalletState {}

final class WalletInfoFailed extends PatWalletState {
  String? errorMessage;
  WalletInfoFailed(this.errorMessage);
}

final class WalletInfoLoading extends PatWalletState {}

final class WalletInfonSuccess extends PatWalletState {}

final class ActivationFailed extends PatWalletState {
  String? errorMessage;
  ActivationFailed(this.errorMessage);
}

final class ActivationSuccess extends PatWalletState {}

final class ActivationLaoding extends PatWalletState {}

final class ChangePinFailed extends PatWalletState {
  String? errorMessage;
  ChangePinFailed(this.errorMessage);
}

final class ChangePinSuccess extends PatWalletState {}

final class ChangePinLaoding extends PatWalletState {}

// transactions
final class TransLaoding extends PatWalletState {}

final class TransSuccess extends PatWalletState {}

final class TransFailed extends PatWalletState {
  String? errorMessage;
  TransFailed(this.errorMessage);
}

final class PagTransLaoding extends PatWalletState {}

final class PagTransSuccess extends PatWalletState {}

final class PagTransFailed extends PatWalletState {
  String? errorMessage;
  PagTransFailed(this.errorMessage);
}
