import 'package:medihive_1_/constant/ApiRoutes.dart';
import 'package:medihive_1_/helper/Api.dart';
import 'package:medihive_1_/helper/Pagination_Result.dart';
import 'package:medihive_1_/helper/Result.dart';
import 'package:medihive_1_/models/Arguments_Models/App_success_info.dart';
import 'package:medihive_1_/models/MyAppointment.dart';

class MyappointmentServices {
  Future<ApiResult> getUpcomingAppService({required String accessToken}) async {
    String params = '?type=upcoming';
    List<Myappointment> data = [];
    try {
      var responseBody =
          await Api().GET(URL: getMyAppUrl, token: accessToken, param: params);
      for (int i = 0; i < responseBody['data'].length; i++) {
        data.add(Myappointment.fromJson(jsonData: responseBody['data'][i]));
      }
      return ApiResult.success(data);
      /*  return List<Myappointment>.generate(responseBody['data'].length, (index)
      => Myappointment.fromJson(responseBody)); */
    } on Exception catch (ex) {
      return ApiResult.failure(ex.toString().substring(10));
    }
  }

  Future<ApiResult> getCompletedAppService(
      {required String token, int? page}) async {
    String params;
    if (page != null) {
      params = '?type=completed&page=$page';
    } else {
      params = '?type=completed';
    }
    List<Myappointment> data = [];
    try {
      var responseBody =
          await Api().GET(URL: getMyAppUrl, token: token, param: params);
      final last_page = responseBody['meta']['last_page'];
      for (int i = 0; i < responseBody['data'].length; i++) {
        data.add(Myappointment.fromJson(
            jsonData: responseBody['data'][i], page: last_page));
      }
      return ApiResult.success(data);
    } on Exception catch (ex) {
      return ApiResult.failure(ex.toString().substring(10));
    }
  }

  Future<ApiResult> getAbsentAppService(
      {required String token, required int page}) async {
    String params = '?type=absent&page=$page';

    List<Myappointment> data = [];
    try {
      var responseBody =
          await Api().GET(URL: getMyAppUrl, token: token, param: params);
      final last_page = responseBody['meta']['last_page'];
      for (int i = 0; i < responseBody['data'].length; i++) {
        data.add(Myappointment.fromJson(
            jsonData: responseBody['data'][i], page: last_page));
      }
      return ApiResult.success(
          PaginatedResult(items: data, last_page: last_page));
    } on Exception catch (ex) {
      return ApiResult.failure(ex.toString().substring(10));
    }
  }

  Future<ApiResult> rateDoctorService(
      {required String token,
      required double rating,
      required int appointment_id}) async {
    Map<String, dynamic> body = {
      "appointment_id": appointment_id,
      "rating": rating
    };
    try {
      var responseBody =
          await Api().POST(URL: rateAppUrl, body: body, token: token);
      return ApiResult.success(
          responseBody['success']); // هون القيمة bool  ما بعرف شو الkey
    } on Exception catch (ex) {
      return ApiResult.failure(ex.toString().substring(10));
    }
  }

  Future<ApiResult> cancelAppointmentService(
      {required String token,
      required String reson,
      required int appointment_id}) async {
    try {
      Map<String, dynamic> body = {"reason": reson};
      await Api().DELETE(
          URL: '${cancelAppUrl}$appointment_id', token: token, body: body);

      return ApiResult.success(true);
    } on Exception catch (ex) {
      return ApiResult.failure(ex.toString().substring(10));
    }
  }

  Future<ApiResult> EditAppointment(
      {required String token,
      required int time_slot_id,
      required int doctor_id,
      required int appointment_id}) async {
    Map<String, dynamic> body = {
      "doctor_id": doctor_id,
      "time_slot_id": time_slot_id,
    };
    try {
      var responseBody = await Api()
          .PUT(URL: '${editAppUrl}$appointment_id', body: body, token: token);
      return ApiResult.success(AppSuccessInfo.fromJson(responseBody));
    } on Exception catch (ex) {
      return ApiResult.failure(ex.toString().substring(10));
    }
  }
}
