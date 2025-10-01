import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/helper/Result.dart';
import 'package:medihive_1_/models/DoctorAppointment.dart';
import 'package:medihive_1_/models/Prescription.dart';
import 'package:medihive_1_/pages/Auth/cubit/auth_cubit_cubit.dart';
import 'package:medihive_1_/pages/User_Doctor/Home/services/Doc_App_Service.dart';
import 'package:meta/meta.dart';
import 'dart:async';
import 'package:async/async.dart';
part 'doctor_appointment_state.dart';

class DoctorAppointmentCubit extends Cubit<DoctorAppointmentState> {
  DoctorAppointmentCubit() : super(DoctorAppointmentInitial());
  List<Doctorappointment> appointment = [];
  Timer? _debounceTime;
  CancelableOperation? _apiAppOperation;
  int page = 1;
  bool hasMoreApp = true;

  Future<void> loadDoctorAppointment(
      {required BuildContext context,
      required String type,
      required String date,
      bool isRefreshing = false}) async {
    _cancelPreviousApirecords();
    _debounceTime = Timer(Duration(milliseconds: 250), () async {
      await _excuteApiOperation(
          context: context, type: type, date: date, ispagaing: isRefreshing);
    });
  }

  void paginateDoctorApp(
      {required BuildContext context,
      required String type,
      required String date}) {
    _excuteApiOperation(
        context: context, type: type, date: date, ispagaing: true);
  }

  void _cancelPreviousApirecords() {
    _debounceTime?.cancel();
    _debounceTime = null;
    _apiAppOperation?.cancel();
    _apiAppOperation = null;
    // reset data and pages when navigation not pagination operation
    appointment.clear();
    page = 1;
    hasMoreApp = true;
  }

  Future<void> _excuteApiOperation(
      {required BuildContext context,
      required String type,
      required String date,
      bool ispagaing = false}) async {
    final token = context.read<AuthCubit>().access_token;
    try {
      if (token == null) {
        emit(AppointmentFailed('UnAuthorized'));
        return;
      }
      if (hasMoreApp) {
        if (!ispagaing) {
          emit(AppointmentLoading());
        }
        _apiAppOperation = CancelableOperation.fromFuture(DocAppService()
            .getDoctorAppService(
                token: token, type: type, date: date, page: page));
        ApiResult result = await _apiAppOperation?.value;
        if (result.isSuccess) {
          page++;
          hasMoreApp = page <= result.data.last_page;
          appointment.addAll(result.data.items);
          emit(AppointmentSucess());

          return;
        } else {
          emit(AppointmentFailed(result.error));
          return;
        }
      }
    } on Exception catch (e) {
      // TODO
      emit(AppointmentFailed(e.toString()));
    }
  }

  Future<void> markAsAbsent(
      {required BuildContext context,
      required int appointment_id,
      required int data_index,
      required String patient_name}) async {
    try {
      final token = context.read<AuthCubit>().access_token;

      if (token == null) {
        emit(AbsentFailed(
            errorMessage: 'UnAuthorized',
            apiMessage: null,
            patinet_name: patient_name,
            appointment_id: appointment_id,
            index: data_index));
        return;
      }
      var result = await DocAppService()
          .markAsAbsent(token: token, appointment_id: appointment_id);
      if (result.isSuccess) {
        emit(AbsentSuccess(
            data_index: data_index,
            SuccessMessage: '${patient_name} appointment is absent'));
        return;
      } else {
        emit(AbsentFailed(
            apiMessage: result.error ?? 'Error',
            patinet_name: patient_name,
            errorMessage: 'Error on ${patient_name} appointment',
            appointment_id: appointment_id,
            index: data_index));
      }
    } on Exception catch (e) {
      // TODO
      emit(AbsentFailed(
          apiMessage: e.toString(),
          errorMessage: null,
          patinet_name: patient_name,
          appointment_id: appointment_id,
          index: data_index));
    }
  }

  Future<void> markAsCompleted(
      {required BuildContext context,
      required Doctorappointment data,
      required int index}) async {
    try {
      final token = context.read<AuthCubit>().access_token;
      if (token == null) {
        emit(CompletedFailed(
            appointment: data, error: 'UnAutorized', data_index: index));
        return;
      }
      var result = await DocAppService()
          .markAsCompleted(token: token, appointment_id: data.appointmentId);
      if (result.isSuccess) {
        // removing the data member
        appointment.removeAt(index);
        emit(CompletedSucces(
            message: '${data.patientName} appointment is completed'));
        return;
      } else {
        emit(CompletedFailed(
            appointment: data, error: result.error, data_index: index));
        return;
      }
    } on Exception catch (e) {
      // TODO
      emit(CompletedFailed(
          appointment: data, error: e.toString(), data_index: index));
    }
  }

  Future<void> cancelAppointmet(
      {required BuildContext context,
      required String reason,
      required List<int> app_ids,
      required List<int> data_index}) async {
    try {
      final token = context.read<AuthCubit>().access_token;
      if (token == null) {
        emit(CancelFailed(
            appointments_ids: app_ids,
            data_index: data_index,
            reason: reason,
            error: 'UnAuthorized'));
        return;
      }
      var reslut = await DocAppService().cnacelAppointment(
          token: token, appointment_ids: app_ids, reason: reason);
      if (reslut.isSuccess) {
        _removeAppointmentByIndex(data_index);
        emit(CancelSucces());
        return;
      } else {
        emit(CancelFailed(
            appointments_ids: app_ids,
            data_index: data_index,
            error: reslut.error,
            reason: reason));
        return;
      }
    } on Exception catch (e) {
      // TODO
      emit(CancelFailed(
          appointments_ids: app_ids,
          data_index: data_index,
          reason: reason,
          error: e.toString()));
    }
  }

  Future<void> addMedicalReport(
      {required BuildContext context,
      required int appointment_id,
      required String? title,
      required String? content,
      required List<Prescription> presData,
      required int index}) async {
    try {
      final token = context.read<AuthCubit>().access_token;
      if (token == null) {
        emit(ReportFailed(error: 'UnAuthorized'));
        return;
      }
      emit(ReportLoading());
      var result = await DocAppService().addReportService(
          token: token,
          appointment_id: appointment_id,
          body: _createReportBody(
              title: title, content: content, presData: presData));
      if (result.isSuccess) {
        appointment.removeAt(index);
        emit(ReportSuccess());
        return;
      } else {
        emit(ReportFailed(error: result.error));
      }
    } on Exception catch (e) {
      // TODO
      emit(ReportFailed(error: e.toString()));
    }
  }

  clearAppointment({required int index}) {
    appointment.removeAt(index);
  }

  _removeAppointmentByIndex(List<int> indexes) {
    indexes.sort((a, b) => b.compareTo(a));

    // الحذف من الأكبر إلى الأصغر
    for (int index in indexes) {
      if (index >= 0 && index < appointment.length) {
        appointment.removeAt(index);
      }
    }
  }

  Map<String, dynamic> _createReportBody(
      {required String? title,
      required String? content,
      required List<Prescription> presData}) {
    return {
      "title": title,
      "content": content,
      "prescriptions": presData.map((pres) => pres.toMapElement()).toList(),
    };
  }
}
