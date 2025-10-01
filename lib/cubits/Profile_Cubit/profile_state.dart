part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileSuccess extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileFailed extends ProfileState {
  String? errorMessage;
  ProfileFailed({this.errorMessage});
}

final class ActivitySuccess extends ProfileState {}

final class Activityloading extends ProfileState {}

final class ActivityFialed extends ProfileState {
  String error;
  ActivityFialed({required this.error});
}
