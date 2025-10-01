import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/models/Doctor.dart';
import 'package:medihive_1_/pages/Auth/cubit/auth_cubit_cubit.dart';
import 'package:medihive_1_/pages/User_Patient/Home/services/TopDoctorsService.dart';

part 'top_doctors_state.dart';

class TopDoctorsCubit extends Cubit<TopDoctorsState> {
  TopDoctorsCubit() : super(TopDoctorsInitial());
  List<Doctor> topDoctors = [];

  loadTopDoctors(BuildContext context) async {
    emit(TDoctorsLoading());
    try {
      final accessToken = BlocProvider.of<AuthCubit>(context).access_token;

      if (accessToken != null) {
        var response = await Topdoctorsservice()
            .getTopDoctorsService(access_token: accessToken);
        if (response is List<Doctor>) {
          topDoctors = response;
          emit(TDoctorsSuccess());
        } else {
          emit(TDoctorsFailed('$response'));
        }
      } else {
        emit(TDoctorsFailed('UnAuthorized'));
      }
    } on Exception catch (ex) {
      emit(TDoctorsFailed(ex.toString()));
    }
  }
}
