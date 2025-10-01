import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/models/Medical_Report.dart';
import 'package:medihive_1_/models/MyAppointment.dart';
import 'package:medihive_1_/pages/Auth/cubit/auth_cubit_cubit.dart';
import 'package:medihive_1_/pages/User_Patient/Medical_History/Services/Medical_History_Service.dart';

part 'medical_history_state.dart';

class MedicalHistoryCubit extends Cubit<MedicalHistoryState> {
  MedicalHistoryCubit() : super(MedicalHistoryInitial());
  List<Myappointment> data = [];
  int _page_num = 1;
  bool hasMore = true;
  late MedicalReport report;

  getMedicalHistory({
    required BuildContext context,
    required int? clinic_id,
    required String? date,
  }) async {
    try {
      // تجربة اخذ الtoken  من Auth Cubit
      final accessToken = BlocProvider.of<AuthCubit>(context).access_token;

      if (accessToken == null) {
        emit(FailedMH('UnAuthorized!'));
        return;
      }
      if (hasMore) {
        if (_page_num <= 1) {
          emit(LoadingMH());
        }
        var result = await MedicalHistoryService().getMedHistoryservice(
            token: accessToken,
            clinic_id: clinic_id,
            date: date,
            page_num: _page_num);
        if (result.isSuccess) {
          data.addAll(result.data.items);
          _page_num++;
          hasMore = _page_num <= result.data.last_page;
          emit(successMH());
          return;
        } else {
          emit(FailedMH(result.error));
          return;
        }
      }
    } on Exception catch (ex) {
      emit(FailedMH(ex.toString()));
    }
  }

  Future<void> getReportMethod({
    required BuildContext context,
    required int appointment_id,
  }) async {
    try {
      // تجربة اخذ الtoken  من Auth Cubit
      final accessToken = BlocProvider.of<AuthCubit>(context).access_token;

      if (accessToken == null) {
        emit(ReportFailed('UnAuthorized!'));
        return;
      }
      emit(ReportLoading());
      var result = await MedicalHistoryService().getMedicalReportService(
        token: accessToken,
        appointment_id: appointment_id,
      );
      if (result.isSuccess) {
        report = result.data;
        emit(ReportSuccess());
        return;
      } else {
        emit(ReportFailed(result.error));
        return;
      }
    } on Exception catch (ex) {
      emit(ReportFailed(ex.toString()));
    }
  }

  Future<void> getReportForDoctor(
      {required BuildContext context,
      required int id,
      required String type}) async {
    try {
      // تجربة اخذ الtoken  من Auth Cubit
      final accessToken = BlocProvider.of<AuthCubit>(context).access_token;

      if (accessToken == null) {
        emit(ReportFailed('UnAuthorized!'));
        return;
      }
      emit(ReportLoading());
      var result = await MedicalHistoryService()
          .getReportForDoctor(token: accessToken, id: id, type: type);
      if (result.isSuccess) {
        report = result.data;
        emit(ReportSuccess());
        return;
      } else {
        emit(ReportFailed(result.error));
        return;
      }
    } on Exception catch (ex) {
      emit(ReportFailed(ex.toString()));
    }
  }

  resetSittingsforFilter() {
    hasMore = true;
    _page_num = 1;
    data.clear();
    emit(successMH());
  }
}
