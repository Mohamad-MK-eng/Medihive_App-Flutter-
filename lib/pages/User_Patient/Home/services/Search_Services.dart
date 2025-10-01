import 'package:medihive_1_/constant/ApiRoutes.dart';
import 'package:medihive_1_/helper/Api.dart';
import 'package:medihive_1_/helper/Result.dart';
import 'package:medihive_1_/models/Clinic.dart';
import 'package:medihive_1_/models/Doctor.dart';

class SearchServices {
  Future<ApiResult> searchClinicService(
      String searchContent, String token) async {
    try {
      List<Clinic> clinics = [];
      String params = '?name=$searchContent';

      var responseBody =
          await Api().GET(URL: searchClinicUrl, token: token, param: params);

      for (int i = 0; i < responseBody['data'].length; i++) {
        //  here  to add Clinic to List
        clinics.add(Clinic.fromJson(responseBody['data'][i]));
      }
      return ApiResult.success(clinics);
    } on Exception catch (ex) {
      return ApiResult.failure(ex.toString().substring(10));
    }
  }

  Future<ApiResult> searchDoctorService(
      String searchContent, String token) async {
    List<Doctor> doctors = [];
    String params = '?keyword=$searchContent';
    try {
      var responseBody =
          await Api().GET(URL: searchDoctorUrl, token: token, param: params);

      for (int i = 0; i < responseBody['data'].length; i++) {
        //  here  to add Doctors to List
        doctors.add(Doctor.fullFromJson(responseBody['data'][i]));
      }

      return ApiResult.success(doctors);
    } on Exception catch (ex) {
      return ApiResult.failure(ex.toString().substring(10));
    }
  }
}
