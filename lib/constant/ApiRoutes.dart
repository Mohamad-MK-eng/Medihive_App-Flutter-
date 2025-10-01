String baseUrl = 'http://$host:$port/api/';
String prefixPatient = 'patient/';
// for emulator
String host = '';

changeIPMethod({required String ip}) {
  host = ip;
}

///'192.168.41.161'; //'192.168.1.100';

String port = '8000';
// Auth
String loginUrl = '${baseUrl}login';
String registerUrl = '${baseUrl}register';
String logoutUrl = '${baseUrl}logout';
String change_passwordUrl = '${baseUrl}change_password';
String forget_password = '${baseUrl}forgot-password';
String reset_pass_url = '${baseUrl}reset-password';
//Clinics
String FetchClinicsUrl = '${baseUrl}clinics';

String FetchDocotrsOfClinicUrl({required clinic_id}) =>
    '${baseUrl}clinics/$clinic_id/doctors'; // هون بين الطبيب والعيادة في id
// doctors
String FetchDoctorDetailsUrl({required doctor_id}) =>
    '${baseUrl}doctors/$doctor_id'; // هون اخر شي لازم يكون id

String FetchTopDoctorsUrl = '${baseUrl}doctors/top';

// profile

String FethcProfileInfoUrl = '${baseUrl}patient/profile';

String updateProfileInfoUrl = '${baseUrl}patient/profile';

String updatePatProfileImage = '${baseUrl}patient/profile_picture';

// search
String searchDoctorUrl = '${baseUrl}search/doctors';

String searchClinicUrl = '${baseUrl}search/clinics';

// appointment
String getDoctorDaysUrl(int doctor_id) {
  return "${baseUrl}doctors/$doctor_id/available_slots";
}

String getDoctorTimesUrl(int doctor_id, String full_date) =>
    '${baseUrl}doctors/$doctor_id/available_times/$full_date';
// هون بس نوع التابع بيختلف
final getAndbookAppUrl = "${baseUrl}appointments";

//  patinet wallet
String getWalletInfoUrl = '${baseUrl}wallet/balance';
String activatePatWalletUrl = '${baseUrl}wallet/setup';
String changePinUrl = '${baseUrl}wallet/change_pin';
String getWalletTrasUrl = "${baseUrl}payments/history";
// appointment
String getMyAppUrl = "${baseUrl}appointments/patient"; // params
String rateAppUrl = "${baseUrl}patient/ratings";
String cancelAppUrl = "${baseUrl}appointments/";
String editAppUrl = "${baseUrl}appointments/";

// medical history
String getMedHistUrl = "${baseUrl}patient/appointments/history"; // params
String getReportOfHistory({required int appointment_id}) {
  return "${baseUrl}appointments/$appointment_id/reports";
}

// doctor Appliction
String getDoctorProfileUrl = '${baseUrl}profile';
String updateDoctorProfileUrl = '${baseUrl}profile';
String updateDoctorProfileImageUrl = '${baseUrl}profile_picture';

String getDoctorPatientsUrl = '${baseUrl}doctor/specific/patients';
String searchDoctorPatientUrl = '${baseUrl}doctor/search/patients';
String getPatProfileUrl({required int patient_id}) =>
    '${baseUrl}doctor/patients/$patient_id/profile';
String getPatReportseUrl({required int patient_id}) =>
    '${baseUrl}doctor/patients/$patient_id/documents';
String getPatPresUrl({required int report_id}) =>
    '${baseUrl}patients/$report_id/documents';

// doctor appointment ......................
String getDocAppUrl = '${baseUrl}appointments';
String markAsAbsentUrl({required int appointment_id}) {
  return '${baseUrl}doctor/appointments/$appointment_id/absent';
}

String markAsCompletedUrl({required int appointment_id}) {
  return '${baseUrl}doctor/appointments/$appointment_id/complete';
}

String cancelDoctorAppUrl = '${baseUrl}doctor/appointments/emergency_cancel';

String addReportUrl({required int appointment_id}) {
  return '${baseUrl}doctor/appointments/$appointment_id/reports';
}

String getRportForDoctor({required int id}) {
  return '${baseUrl}doctor/documents/$id/prescriptions';
}

String updateActivityUrl = '${baseUrl}doctor/activity';
