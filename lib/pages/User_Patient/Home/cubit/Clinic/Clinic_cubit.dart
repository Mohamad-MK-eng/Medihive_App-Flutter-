import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/models/Clinic.dart';
import 'package:medihive_1_/pages/Auth/cubit/auth_cubit_cubit.dart';
import 'package:medihive_1_/pages/User_Patient/Home/services/Clinic_Services.dart';

part 'Clinic_state.dart';

class ClinicCubit extends Cubit<ClinicState> {
  ClinicCubit() : super(ClinicsInitial());
  List<Clinic> clinics = [];

  loadClinics(BuildContext context) async {
    emit(ClinicsLoading());
    try {
      // تجربة اخذ الtoken  من Auth Cubit
      final accessToken = BlocProvider.of<AuthCubit>(context).access_token;

      if (accessToken != null) {
        var response =
            await ClinicServices().getClinicsService(accessToken: accessToken);
        if (response is List<Clinic>) {
          clinics = response;
          emit(ClinicsSuccess());
        } else {
          emit(ClinicsFailed('$response'));
        }
      } else {
        emit(ClinicsFailed('UnAuthorized'));
      }
    } on Exception catch (ex) {
      emit(ClinicsFailed(ex.toString()));
    }
  }
}
