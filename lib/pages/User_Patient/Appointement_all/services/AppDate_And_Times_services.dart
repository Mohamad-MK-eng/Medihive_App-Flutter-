import 'package:medihive_1_/constant/ApiRoutes.dart';
import 'package:medihive_1_/helper/Api.dart';
import 'package:medihive_1_/models/AppDate_and_Times.dart';

class AppdateAndTimesServices {
  getAppDaysServices(String token, int doctor_id) async {
    List<AppDate> days = [];
    late AppDateTime earliest_date;
    try {
      var responseBody = await Api().GET(
        URL: getDoctorDaysUrl(doctor_id),
        token: token,
      );
      for (int i = 0; i < responseBody['days'].length; i++) {
        // response body مو هي الصيغة النهائية بدي اعرف شو key
        days.add(AppDate.fromJson(responseBody['days'][i]));
      }
      earliest_date = AppDateTime.fromJson(responseBody['earliest_date']);

      Map<String, dynamic> result = {
        'days': days,
        'earliest_date': earliest_date
      };
      return result;
    } on Exception catch (ex) {
      return ex.toString().substring(10);
    }
  }

  getAppTimesServices(String token, String full_date, int doctor_id) async {
    List<AppTime> times = [];

    try {
      var responseBody = await Api()
          .GET(URL: getDoctorTimesUrl(doctor_id, full_date), token: token);
      for (int i = 0; i < responseBody['times'].length; i++) {
        times.add(AppTime.fromJson(responseBody['times'][i]));
      }
      return times;
    } on Exception catch (ex) {
      return ex.toString().substring(10);
    }
  }
}
