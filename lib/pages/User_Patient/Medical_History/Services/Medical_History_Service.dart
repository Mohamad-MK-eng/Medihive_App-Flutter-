import 'package:medihive_1_/constant/ApiRoutes.dart';
import 'package:medihive_1_/helper/Api.dart';
import 'package:medihive_1_/helper/Pagination_Result.dart';
import 'package:medihive_1_/helper/Result.dart';
import 'package:medihive_1_/models/Medical_Report.dart';
import 'package:medihive_1_/models/MyAppointment.dart';

class MedicalHistoryService {
  Future<ApiResult> getMedHistoryservice(
      {required String token,
      required int? clinic_id,
      required String? date,
      required int page_num}) async {
    try {
      List<Myappointment> data = [];
      String params = _detectFilterType(
          clinic_id: clinic_id, date: date, page_num: page_num);
      var resposeBody =
          await Api().GET(URL: getMedHistUrl, token: token, param: params);
      int last_page = resposeBody['meta']['last_page'];
      data = List<Myappointment>.generate(
          resposeBody['data'].length,
          (index) =>
              Myappointment.fromJson(jsonData: resposeBody['data'][index]));

      return ApiResult.success(
          PaginatedResult(items: data, last_page: last_page));
    } on Exception catch (ex) {
      return ApiResult.failure(ex.toString().substring(10));
    }
  }

  Future<ApiResult> getMedicalReportService({
    required String token,
    required int appointment_id,
  }) async {
    try {
      var responseBody = await Api().GET(
          URL: getReportOfHistory(appointment_id: appointment_id),
          token: token);
      return ApiResult.success(MedicalReport.fromJson(responseBody['report']));
    } on Exception catch (ex) {
      return ApiResult.failure(ex.toString().substring(10));
    }
  }

  Future<ApiResult> getReportForDoctor(
      {required String token, required int id, required String type}) async {
    try {
      String param = '?type=$type';
      var responseBody = await Api()
          .GET(URL: getRportForDoctor(id: id), token: token, param: param);
      return ApiResult.success(MedicalReport.fromJson(responseBody['report']));
    } on Exception catch (ex) {
      return ApiResult.failure(ex.toString().substring(10));
    }
  }

  String _detectFilterType(
      {required int? clinic_id, required String? date, required int page_num}) {
    if (clinic_id == null && date == null) {
      // no filter
      return '?page=$page_num';
    } else if (clinic_id != null && date == null) {
      // clinic filter
      return '?page=$page_num&clinic_id=$clinic_id';
    } else if (date != null && clinic_id == null) {
      // date filter
      return '?page=$page_num&date=$date';
    } else {
      // هون حطيتا للحيطة بس ضل حالة  التنيني مو ب null
      return '?page=$page_num';
    }
  }
}
