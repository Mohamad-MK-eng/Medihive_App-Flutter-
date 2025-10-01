import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/helper/Result.dart';
import 'package:medihive_1_/models/Clinic.dart';
import 'package:medihive_1_/models/Doctor.dart';
import 'package:medihive_1_/pages/Auth/cubit/auth_cubit_cubit.dart';
import 'package:medihive_1_/pages/User_Patient/Home/services/Search_Services.dart';
import 'package:async/async.dart';

part 'search_state.dart';

class PatientSearchCubit extends Cubit<PatientSearchStates> {
  PatientSearchCubit() : super(SearchInitial());
  List<Clinic> clinics = [];
  List<Doctor> doctors = [];
  CancelableOperation? _searchApiOperation;
  Timer? _debounceTime;
  String _lastSearchQuery = '';

  searchClinicMethod(BuildContext context, String searchContent) async {
    _debounceTime?.cancel();
    await _searchApiOperation?.cancel();

    if (searchContent.isEmpty) {
      emit(PatientSearchIni());
      return;
    }

    if (searchContent == _lastSearchQuery || searchContent.length < 3) {
      return;
    }
    _lastSearchQuery = searchContent;

    emit(PSearchClinicLoading());
    _debounceTime = Timer(Duration(milliseconds: 500), () {
      _excuteSearchClinic(context, searchContent);
    });
  }

  Future<void> _excuteSearchClinic(BuildContext context, String content) async {
    try {
      final token = context.read<AuthCubit>().access_token;
      if (token == null) {
        emit(PSearchClinicFailed('UnAuthorized'));
        return;
      }
      _searchApiOperation = CancelableOperation.fromFuture(
          SearchServices().searchClinicService(content, token));

      ApiResult result = await _searchApiOperation!.value;
      if (result.isSuccess) {
        clinics = result.data;
        emit(PSearchClinicSuccess());
        return;
      } else {
        emit(PSearchClinicFailed(result.error));
        return;
      }
    } on Exception catch (ex) {
      emit(PSearchClinicFailed(ex.toString()));
    }
  }

  searchDoctorMethod(BuildContext context, String searchContent) async {
    _debounceTime?.cancel();
    await _searchApiOperation?.cancel();

    if (searchContent.isEmpty) {
      emit(PatientSearchIni());
      return;
    }

    if (searchContent == _lastSearchQuery || searchContent.length < 3) {
      return;
    }
    _lastSearchQuery = searchContent;

    emit(PSearchClinicLoading());
    _debounceTime = Timer(Duration(milliseconds: 500), () {
      _excuteDoctorSearch(context, searchContent);
    });
  }

  Future<void> _excuteDoctorSearch(BuildContext context, String content) async {
    try {
      final token = context.read<AuthCubit>().access_token;
      if (token == null) {
        emit(PSearchDoctorFailed('UnAuthorized'));
        return;
      }
      _searchApiOperation = CancelableOperation.fromFuture(
          SearchServices().searchDoctorService(content, token));

      ApiResult result = await _searchApiOperation!.value;
      if (result.isSuccess) {
        doctors = result.data;
        emit(PSearchDoctorSuccess());
        return;
      } else {
        emit(PSearchDoctorFailed(result.error));
        return;
      }
    } on Exception catch (ex) {
      emit(PSearchDoctorFailed(ex.toString()));
    }
  }
}
