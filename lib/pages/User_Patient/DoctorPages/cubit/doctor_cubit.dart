import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/models/Doctor.dart';
import 'package:medihive_1_/pages/Auth/cubit/auth_cubit_cubit.dart';
import 'package:medihive_1_/pages/User_Patient/DoctorPages/Services/Clinic_Doctors_Service.dart';

part 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  DoctorCubit() : super(DoctorInitial());
  List<Doctor> doctors = [];
  DoctorDetails? doctorDetails;
  loadClinicDortor(int clinic_id, BuildContext context) async {
    emit(DoctorLoading());

    try {
      final accessToken = BlocProvider.of<AuthCubit>(context).access_token;
      if (accessToken != null) {
        var response = await ClinicDoctorsService()
            .getDoctorsOfClinic(clinic_id, accessToken);
        if (response is List<Doctor>) {
          doctors = response;
          emit(DoctorsListSuccess());
        } else {
          emit(DoctorFailed('$response'));
        }
      } else {
        emit(DoctorFailed('UnAuthorized'));
      }
    } on Exception catch (ex) {
      emit(DoctorFailed(ex.toString()));
    }
  }

  loadDoctorDetails(int doctor_id, BuildContext context) async {
    emit(DoctorLoading());

    try {
      final accessToken = BlocProvider.of<AuthCubit>(context).access_token;
      if (accessToken != null) {
        var response = await ClinicDoctorsService()
            .getDoctorDetails(doctor_id, accessToken);
        if (response is DoctorDetails) {
          doctorDetails = response;
          emit(DocotrDetailsSuccess());
        } else {
          emit(DoctorFailed('$response'));
        }
      } else {
        emit(DoctorFailed('UnAuthorized'));
      }
    } on Exception catch (ex) {
      emit(DoctorFailed(ex.toString()));
    }
  }
}
