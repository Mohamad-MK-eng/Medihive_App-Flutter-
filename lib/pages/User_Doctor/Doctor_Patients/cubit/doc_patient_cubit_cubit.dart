import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/helper/Result.dart';
import 'package:medihive_1_/models/Doctor_Patient.dart';
import 'package:medihive_1_/models/Pat_Record.dart';
import 'package:medihive_1_/pages/Auth/cubit/auth_cubit_cubit.dart';
import 'package:medihive_1_/pages/User_Doctor/Doctor_Patients/Services/Doctor_Patients_Service.dart';
import 'package:medihive_1_/pages/User_Doctor/Doctor_Patients/Services/Patient_Records_Service.dart';
import 'package:async/async.dart';

part 'doc_patient_cubit_state.dart';

class DocPatientCubit extends Cubit<DocPatientState> {
  DocPatientCubit() : super(DocPatientInitial());
  Timer? _debounceTime;
  CancelableOperation? _apiRecordOperation;
  Timer? _searchDebounce;
  CancelableOperation? _searchapiOperation;
  List<PatRecord> patRecords = [];
  List<DoctorPatient> allPatientsData = [];
  List<DoctorPatient> patSearchData = [];
  int page_num = 1;
  bool hasMorePat = true;
  String _lastSearchQuery = '';

  Future<void> getDoctorPatient({required BuildContext context}) async {
    try {
      final token = context.read<AuthCubit>().access_token;
      if (token == null) {
        emit(PatientsFailed('UnAuthorized'));
        return;
      }
      emit(PatientsLoading());
      if (hasMorePat) {
        final result = await DoctorPatientsService()
            .getDoctorPatientsService(token: token, page: page_num);
        if (result.isSuccess) {
          allPatientsData.addAll(result.data.items);
          page_num++;
          hasMorePat = page_num <= result.data.last_page;
          emit(PatientsSuccess());
          return;
        } else {
          emit(PatientsFailed(result.error));
          return;
        }
      }
    } on Exception catch (ex) {
      emit(PatientsFailed(ex.toString()));
    }
  }

  Future<void> searchPatient(
      {required BuildContext context, required String content}) async {
    _searchDebounce?.cancel();
    await _searchapiOperation?.cancel();

    if (content.isEmpty) {
      emit(PatientsInitial());
      return;
    }

    if (content == _lastSearchQuery || content.length < 3) {
      return;
    }

    _lastSearchQuery = content;

    // إظهار حالة التحميل
    emit(PatientsLoading());

    _searchDebounce = Timer(const Duration(milliseconds: 500), () {
      _executeSearchOperation(context: context, content: content);
    });
  }

  Future<void> _executeSearchOperation(
      {required BuildContext context, required String content}) async {
    try {
      final token = context.read<AuthCubit>().access_token;
      if (token == null) {
        emit(PatientsFailed('UnAuthorized'));
        return;
      }

      _searchapiOperation = CancelableOperation.fromFuture(
        DoctorPatientsService()
            .searchPatientService(token: token, content: content),
      );

      ApiResult result = await _searchapiOperation!.value;

      if (result.isSuccess) {
        patSearchData = result.data;
        emit(PatientsSuccess());
      } else {
        emit(PatientsFailed(result.error ?? 'Unknown error'));
      }
    }
    // تم إلغاء العملية - لا تفعل شيء
    on Exception catch (ex) {
      emit(PatientsFailed(ex.toString()));
    }
  }

  // عملية ال fethc for patient records
  void loadPatRecords(
      {required BuildContext context,
      required String month,
      required String year,
      required int patient_id}) {
    _cancelPreviousApirecords();
    emit(ReportsIni());
    _debounceTime = Timer(Duration(milliseconds: 250), () {
      _excuteApiRecords(
          context: context, month: month, year: year, patient_id: patient_id);
    });
  }

  void _cancelPreviousApirecords() {
    _debounceTime?.cancel();
    _debounceTime = null;
    _apiRecordOperation?.cancel();
    _apiRecordOperation = null;
  }

  Future<void> _excuteApiRecords(
      {required BuildContext context,
      required String month,
      required String year,
      required int patient_id}) async {
    try {
      final token = BlocProvider.of<AuthCubit>(context).access_token;
      if (token == null) {
        emit(ReportsFailed('UnAuthorized'));
        return;
      }
      emit(ReportsLoading());
      _apiRecordOperation = CancelableOperation.fromFuture(
          // Recored service
          PatientRecordsService().getPatReportsService(
              token: token,
              month: month,
              year: year,
              patient_id: patient_id), onCancel: () {
        print('Canceling _debouncing');
      });
      ApiResult? result = await _apiRecordOperation?.value;

      if (result != null && result.isSuccess) {
        patRecords = result.data;
        emit(ReportsSuccess());
        return;
      } else if (result != null && !result.isSuccess) {
        emit(ReportsFailed(result.error));
        return;
      }
    } on Exception catch (ex) {
      emit(ReportsFailed(ex.toString()));
    }
  }

  void exitSearchMode() {
    emit(PatientsSuccess());
  }
}
