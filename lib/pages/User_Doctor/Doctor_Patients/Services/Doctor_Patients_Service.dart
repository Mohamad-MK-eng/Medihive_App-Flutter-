import 'package:medihive_1_/constant/ApiRoutes.dart';
import 'package:medihive_1_/helper/Api.dart';
import 'package:medihive_1_/helper/Pagination_Result.dart';
import 'package:medihive_1_/helper/Result.dart';
import 'package:medihive_1_/models/Doctor_Patient.dart';
import 'package:medihive_1_/models/Patient_Profile.dart';

class DoctorPatientsService {
  Future<ApiResult> getDoctorPatientsService(
      {required String token, required int page}) async {
    try {
      var responseBody = await Api()
          .GET(URL: getDoctorPatientsUrl, token: token, param: '?page=$page');
      var data_list = responseBody['data'];
      final data = List<DoctorPatient>.generate(data_list.length, (index) {
        return DoctorPatient.fromJson(data_list[index]);
      });
      return ApiResult.success(PaginatedResult(
          items: data, last_page: responseBody['meta']['last_page']));
    } on Exception catch (ex) {
      return ApiResult.failure(ex.toString().substring(10));
    }
  }

  Future<ApiResult> searchPatientService(
      {required String token, required String content}) async {
    try {
      String param = '?keyword=$content';
      var responseBody = await Api()
          .GET(URL: searchDoctorPatientUrl, token: token, param: param);
      var data_list = responseBody['data'];
      final data = List<DoctorPatient>.generate(data_list.length, (index) {
        return DoctorPatient.fromJson(data_list[index]);
      });
      return ApiResult.success(data);
    } on Exception catch (ex) {
      return ApiResult.failure(ex.toString().substring(10));
    }
  }

  Future<ApiResult> getPatProfileService(
      {required String token, required int patient_id}) async {
    try {
      var responseBody = await Api()
          .GET(URL: getPatProfileUrl(patient_id: patient_id), token: token);
      return ApiResult.success(PatientProfile.forDoctor(responseBody['data']));
    } on Exception catch (ex) {
      return ApiResult.failure(ex.toString().substring(10));
    }
  }
}
