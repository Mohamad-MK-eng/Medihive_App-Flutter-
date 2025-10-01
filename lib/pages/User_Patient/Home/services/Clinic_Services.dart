import 'package:medihive_1_/constant/ApiRoutes.dart';
import 'package:medihive_1_/helper/Api.dart';
import 'package:medihive_1_/models/Clinic.dart';

class ClinicServices {
  getClinicsService({required String accessToken}) async {
    List<Clinic> Clinics = [];
    try {
      List responseBody =
          await Api().GET(URL: FetchClinicsUrl, token: accessToken);
      for (int i = 0; i < responseBody.length; i++) {
        Clinics.add(Clinic.fromJson(responseBody[i]));
      }
      return Clinics;
    } on Exception catch (ex) {
      return ex.toString().substring(10);
    }
  }
}
