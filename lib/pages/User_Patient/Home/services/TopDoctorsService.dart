import 'package:medihive_1_/constant/ApiRoutes.dart';
import 'package:medihive_1_/helper/Api.dart';
import 'package:medihive_1_/models/Doctor.dart';

class Topdoctorsservice {
  getTopDoctorsService({required String access_token}) async {
    List<Doctor> tDocotrs = [];
    try {
      var responseBody =
          await Api().GET(URL: FetchTopDoctorsUrl, token: access_token);
      var jsonData = responseBody['data'];

      if (jsonData.isNotEmpty) {
        for (int i = 0; i < jsonData.length; i++) {
          //  here  to add Doctors to List
          tDocotrs.add(Doctor.fullFromJson(jsonData[i]));
        }
      } else {
        return tDocotrs;
      }
      return tDocotrs;
    } on Exception catch (ex) {
      return ex.toString().substring(10);
    }
  }
}
