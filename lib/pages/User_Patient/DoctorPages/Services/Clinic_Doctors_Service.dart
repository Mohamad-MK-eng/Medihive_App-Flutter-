import 'package:medihive_1_/constant/ApiRoutes.dart';
import 'package:medihive_1_/helper/Api.dart';
import 'package:medihive_1_/models/Doctor.dart';

class ClinicDoctorsService {
  getDoctorsOfClinic(int clinic_id, String accessToken) async {
    List<Doctor> doctors = [];
    try {
      final responseBody = await Api().GET(
          URL: FetchDocotrsOfClinicUrl(clinic_id: clinic_id),
          token: accessToken);
      for (int i = 0; i < responseBody['doctors'].length; i++) {
        doctors.add(Doctor.fullFromJson(responseBody['doctors'][i]));
      }
      return doctors;
    } on Exception catch (ex) {
      return ex.toString().substring(10);
    }
  }

  getDoctorDetails(int doctor_id, String accessToken) async {
    DoctorDetails doctorDetails;
    try {
      final responseBody = await Api().GET(
          URL: FetchDoctorDetailsUrl(doctor_id: doctor_id), token: accessToken);
      doctorDetails = DoctorDetails.fromJson(responseBody);

      return doctorDetails;
    } on Exception catch (ex) {
      return ex.toString().substring(10);
    }
  }
}
