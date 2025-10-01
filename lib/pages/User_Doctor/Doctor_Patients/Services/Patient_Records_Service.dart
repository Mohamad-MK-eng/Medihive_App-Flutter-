import 'package:medihive_1_/constant/ApiRoutes.dart';
import 'package:medihive_1_/helper/Api.dart';
import 'package:medihive_1_/helper/Result.dart';
import 'package:medihive_1_/models/Pat_Record.dart';

class PatientRecordsService {
  Future<ApiResult> getPatReportsService(
      {required String token,
      required String month,
      required String year,
      required int patient_id}) async {
    try {
      String param = '?year=$year&month=$month';
      var responseBody = await Api().GET(
          URL: getPatReportseUrl(patient_id: patient_id),
          token: token,
          param: param);
      final data = responseBody['data'];
      return ApiResult.success(List<PatRecord>.generate(
          data.length, (index) => PatRecord.fromJson(data[index])));
    } on Exception catch (ex) {
      return ApiResult.failure(ex.toString().substring(10));
    }
  }
}
