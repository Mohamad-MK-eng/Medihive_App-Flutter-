import 'package:medihive_1_/constant/ApiRoutes.dart';
import 'package:medihive_1_/helper/Api.dart';
import 'package:medihive_1_/helper/Pagination_Result.dart';
import 'package:medihive_1_/helper/Result.dart';
import 'package:medihive_1_/models/DoctorAppointment.dart';

class DocAppService {
  Future<ApiResult> getDoctorAppService(
      {required String token,
      required String type,
      required String date,
      required int page}) async {
    try {
      String param = '?type=$type&date=$date&page=$page';
      var responseBody =
          await Api().GET(URL: getDocAppUrl, token: token, param: param);
      final last_page = responseBody['meta']['last_page'];
      final data_list = responseBody['data'];
      final data = List<Doctorappointment>.generate(data_list.length,
          (index) => Doctorappointment.fromJosn(data_list[index]));
      return ApiResult.success(
          PaginatedResult(items: data, last_page: last_page));
    } on Exception catch (ex) {
      return ApiResult.failure(ex.toString().substring(10));
    }
  }

  Future<ApiResult> markAsAbsent(
      {required String token, required int appointment_id}) async {
    try {
      await Api().PATCH(
          URL: markAsAbsentUrl(appointment_id: appointment_id), token: token);
      return ApiResult.success(true);
    } on Exception catch (ex) {
      return ApiResult.failure(ex.toString().substring(10));
    }
  }

  Future<ApiResult> markAsCompleted(
      {required String token, required int appointment_id}) async {
    try {
      await Api().PATCH(
          URL: markAsCompletedUrl(appointment_id: appointment_id),
          token: token);
      return ApiResult.success(true);
    } on Exception catch (ex) {
      return ApiResult.failure(ex.toString().substring(10));
    }
  }

  Future<ApiResult> cnacelAppointment(
      {required String token,
      required List<int> appointment_ids,
      required String reason}) async {
    try {
      final Map<String, dynamic> body = {
        'appointment_ids': appointment_ids,
        'reason': reason,
        'is_emergency': true,
      };
      var responseBody = await Api()
          .POST_JSON(URL: cancelDoctorAppUrl, body: body, token: token);
      return ApiResult.success(true);
    } on Exception catch (ex) {
      return ApiResult.failure(ex.toString().substring(10));
    }
  }

  Future<ApiResult> addReportService(
      {required String token,
      required int appointment_id,
      required body}) async {
    try {
      var responseBody = await Api().POST_JSON(
          URL: addReportUrl(appointment_id: appointment_id),
          body: body,
          token: token);
      return ApiResult.success(true);
    } on Exception catch (ex) {
      return ApiResult.failure(ex.toString().substring(10));
    }
  }
}
