import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/models/MyAppointment.dart';
import 'package:medihive_1_/pages/Auth/cubit/auth_cubit_cubit.dart';
import 'package:medihive_1_/pages/User_Patient/Appointement_all/services/MyAppointment_Services.dart';

part 'my_appointment_state.dart';

class MyAppointmentCubit extends Cubit<MyAppointmentState> {
  MyAppointmentCubit() : super(MyAppointmentInitial());
  List<Myappointment> upcomingList = [];
  List<Myappointment> completedList = [];
  List<Myappointment> absentList = [];
  int pageNum = 1;
  bool hasMoreCom = false;
  int absentPagenum = 1;
  bool hasMoreAbs = true;

  getUpcomingAppMethod({required BuildContext context}) async {
    emit(UpcomingLoading());
    try {
      // تجربة اخذ الtoken  من Auth Cubit
      final accessToken = BlocProvider.of<AuthCubit>(context).access_token;

      if (accessToken != null) {
        var response = await MyappointmentServices()
            .getUpcomingAppService(accessToken: accessToken);
        if (response.isSuccess) {
          upcomingList = response.data;

          emit(UpcomingSuccess());
          return;
        } else {
          emit(UpcomingFailed(response.error));
          return;
        }
      } else {
        emit(UpcomingFailed('UnAuthorized'));
        return;
      }
    } on Exception catch (ex) {
      emit(UpcomingFailed(ex.toString()));
    }
  }

  Future<void> getCompletedAppMethod({
    required BuildContext context,
    bool isPaginating = false,
  }) async {
    try {
      // تجربة اخذ الtoken  من Auth Cubit
      final accessToken = BlocProvider.of<AuthCubit>(context).access_token;

      if (accessToken == null) {
        emit(CompletedFailed('UnAuthorized'));
        return;
      }
      if (isPaginating)
        await _handlePaginatingCompleted(token: accessToken);
      else
        await _handleInitialCompleted(token: accessToken);
    } on Exception catch (ex) {
      emit(CompletedFailed(ex.toString()));
    }
  }

  Future<void> getAbsentApp({required BuildContext context}) async {
    try {
      final accessToken = BlocProvider.of<AuthCubit>(context).access_token;

      if (accessToken == null) {
        emit(AbsentFailed('UnAuthorized'));
        return;
      }
      if (hasMoreAbs) {
        emit(AbsentLoading());
        var result = await MyappointmentServices()
            .getAbsentAppService(token: accessToken, page: absentPagenum);
        if (result.isSuccess) {
          absentPagenum++;
          hasMoreAbs = absentPagenum <= result.data.last_page;
          absentList.addAll(result.data.items);
          emit(AbsentSuccess());
          return;
        } else {
          emit(AbsentFailed(result.error));
          return;
        }
      }
    } on Exception catch (ex) {
      emit(AbsentFailed(ex.toString()));
    }
  }

  rateInitilaEmti() {
    emit(RateInitila());
  }

  cancelAppointmentMethod(
      {required BuildContext context,
      required String reason,
      required int appointment_id}) async {
    try {
      final accessToken = BlocProvider.of<AuthCubit>(context).access_token;

      if (accessToken == null) {
        emit(CompletedFailed('UnAuthorized'));
        return;
      }
      emit(CancelLoading());
      final result = await MyappointmentServices().cancelAppointmentService(
          token: accessToken, reson: reason, appointment_id: appointment_id);
      if (result.isSuccess) {
        emit(CancelSuccess());
        return;
      } else {
        emit(CancelFailed(result.error));
      }
    } on Exception catch (ex) {
      emit(CancelFailed(ex.toString()));
    }
  }

  Future<void> rateAppMethod(
      {required BuildContext context,
      required int appointment_id,
      required double rate}) async {
    try {
      final accessToken = BlocProvider.of<AuthCubit>(context).access_token;

      if (accessToken == null) {
        emit(RateFailed('UnAuthorized'));
        return;
      }
      emit(RateLoading());
      var result = await MyappointmentServices().rateDoctorService(
          token: accessToken, rating: rate, appointment_id: appointment_id);
      if (result.isSuccess) {
        emit(RateSuccess());
        result;
      } else {
        emit(RateFailed(result.error));
      }
    } on Exception catch (ex) {
      emit(RateFailed(ex.toString()));
    }
  }

  Future<void> _handlePaginatingCompleted({required String token}) async {
    if (!hasMoreCom) return;
    emit(PagCompletedLoading());
    final result = await MyappointmentServices()
        .getCompletedAppService(token: token, page: pageNum);
    if (result.isSuccess) {
      pageNum++;
      hasMoreCom = pageNum <= result.data[0].last_page;
      completedList.addAll(result.data);
      emit(PagCompletedSuccess());
      return;
    }
    emit(PagCompletedFailed(result.error));
  }

  Future<void> _handleInitialCompleted({required String token}) async {
    emit(CompletedLoading());
    final result =
        await MyappointmentServices().getCompletedAppService(token: token);
    if (result.isSuccess) {
      completedList.addAll(result.data);
      pageNum++;
      if (result.data.isNotEmpty)
        hasMoreCom = pageNum <= result.data[0].last_page;

      emit(CompletedSuccess());
      return;
    }
    emit(CompletedFailed(result.error));
  }
}
