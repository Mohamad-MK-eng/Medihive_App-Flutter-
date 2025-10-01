class PatientProfile {
  // personal information
  String first_name;
  String last_name;
  String? email;
  String? profile_picture_url;

  String? phoneNum;
  String? birthDate;
  String? address;
  // medical information
  PatientMedicalInfo? medicalInfo;
  // هاد للمرة الأولى من التسجيل
  PatientProfile({
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.profile_picture_url,
    this.phoneNum,
    this.birthDate,
    this.address,
    this.medicalInfo,
  });

  factory PatientProfile.fromJson(jsonData) {
    final patient = jsonData['patient'];
    return PatientProfile(
        first_name: patient['first_name'],
        last_name: patient['last_name'],
        email: patient['email'],
        profile_picture_url: patient['profile_picture_url'],
        phoneNum: patient['phone_number'],
        address: patient['address'],
        birthDate: patient['date_of_birth'],
        medicalInfo: PatientMedicalInfo(
            gender: patient['gender'],
            bloodType: patient['blood_type'],
            conditions: patient['chronic_conditions']));
  }
  factory PatientProfile.forDoctor(json) {
    return PatientProfile(
        first_name: json['first_name'],
        last_name: json['last_name'],
        email: null,
        profile_picture_url: json['profile_picture_url'],
        phoneNum: json['phone'],
        address: json['address'],
        birthDate: json['age'].toString(),
        medicalInfo: PatientMedicalInfo(
            gender: json['gender'],
            bloodType: json['blood_type'],
            conditions: json['chronic_conditions']));
  }
}

class PatientMedicalInfo {
  String? gender;
  String? bloodType;
  String? conditions;
  PatientMedicalInfo({
    required this.gender,
    required this.bloodType,
    required this.conditions,
  });
  factory PatientMedicalInfo.fromjosn(jsonData) {
    return PatientMedicalInfo(
        gender: jsonData['gender'],
        bloodType: jsonData['blood_type'],
        conditions: jsonData['chronic_conditions']);
  }
}
