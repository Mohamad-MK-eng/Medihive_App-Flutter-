import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/models/AppDate_and_Times.dart';
import 'package:medihive_1_/models/Arguments_Models/App_success_info.dart';
import 'package:medihive_1_/pages/Auth/cubit/auth_cubit_cubit.dart';
import 'package:medihive_1_/pages/User_Patient/Appointement_all/services/AppDate_And_Times_services.dart';
import 'package:medihive_1_/pages/User_Patient/Appointement_all/services/MyAppointment_Services.dart';

part 'appointment_date_state.dart';

class AppointmentDateCubit extends Cubit<AppointmentDateState> {
  AppointmentDateCubit() : super(AppointmentDateInitial());
  List<AppDate> days = [];
  List<AppTime> times = [];
  AppDateTime? earliest_date;
  AppSuccessInfo? editedAppInfo;
  getAppDaysMethod(BuildContext context, int doctor_id) async {
    emit(AppointmentDaysloading());
    try {
      // تجربة اخذ الtoken  من Auth Cubit
      final accessToken = BlocProvider.of<AuthCubit>(context).access_token;

      if (accessToken != null) {
        var response = await AppdateAndTimesServices()
            .getAppDaysServices(accessToken, doctor_id);
        if (response is Map<String, dynamic>) {
          days = response['days'];
          earliest_date = response['earliest_date'];
          emit(AppointmentDaysSuccess());
        } else {
          emit(AppointmentDaysFailed('$response'));
        }
      } else {
        emit(AppointmentDaysFailed('UnAuthorized'));
      }
    } on Exception catch (ex) {
      emit(AppointmentDaysFailed(ex.toString()));
    }
  }

  getAppTimesMethod(
      BuildContext context, int doctor_id, String full_date) async {
    emit(AppointmentTimesloading());
    try {
      // تجربة اخذ الtoken  من Auth Cubit
      final accessToken = BlocProvider.of<AuthCubit>(context).access_token;

      if (accessToken != null) {
        var response = await AppdateAndTimesServices()
            .getAppTimesServices(accessToken, full_date, doctor_id);
        if (response is List<AppTime>) {
          times = response;
          emit(AppointmentTimesSuccess());
        } else {
          emit(AppointmentTimesFailed('$response'));
        }
      } else {
        emit(AppointmentTimesFailed('UnAuthorized'));
      }
    } on Exception catch (ex) {
      emit(AppointmentTimesFailed(ex.toString()));
    }
  }

  updateAppointmentMethod(
      {required BuildContext context,
      required int doctor_id,
      required int time_slot_id,
      required int appointment_id}) async {
    try {
      emit(EditLoading());
      final accessToken = BlocProvider.of<AuthCubit>(context).access_token;
      if (accessToken == null) {
        emit(EditFailed('UnAuthorized'));
        return;
      }
      var reslut = await MyappointmentServices().EditAppointment(
          token: accessToken,
          time_slot_id: time_slot_id,
          doctor_id: doctor_id,
          appointment_id: appointment_id);
      if (reslut.isSuccess) {
        editedAppInfo = reslut.data;
        emit(EditSuccess());
        return;
      } else {
        emit(EditFailed(reslut.error));
        return;
      }
    } on Exception catch (ex) {
      emit(EditFailed(ex.toString()));
    }
  }

  resetTimes() {
    times.clear();
    emit(AppointmentTimesReset());
  }

  tryit() {
    emit(AppointmentTimesSuccess());
  }
}
