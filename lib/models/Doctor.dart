class Doctor {
  int id;
  String first_name;
  String last_name;
  String specialty;
  String? image_path;
  double? rate;
  int? experience_years;

  Doctor(
      {required this.id,
      required this.first_name,
      required this.last_name,
      required this.specialty,
      required this.image_path,
      this.rate = null,
      this.experience_years = null});
  // هي للنسخة تبع top  واطباء العيادات
  factory Doctor.fullFromJson(jsonData) {
    return Doctor(
        id: jsonData['id'] ?? jsonData['doctor_id'],
        first_name: jsonData['first_name'],
        last_name: jsonData['last_name'],
        specialty: jsonData['specialty'],
        image_path: jsonData['profile_picture_url'],
        rate: (jsonData['rate'] as num).toDouble(),
        experience_years: jsonData['experience_years']);
  }
  //  للنسخة الصغيرة تبع المواعيد والسجل   و
  factory Doctor.lightJson(jsonData) {
    return Doctor(
        id: jsonData['doctor_id'],
        specialty: jsonData['specialty'],
        first_name: jsonData['first_name'],
        last_name: jsonData['last_name'],
        image_path: jsonData['profile_picture_url']);
  }
}

class DoctorDetails {
  int? reviews_count;
  String? bio;
  String? fee;
  double? rate;
  bool is_active = true;

  List<String?> workingDays;
  DoctorDetails(
      {required this.reviews_count,
      required this.bio,
      required this.fee,
      required this.workingDays,
      required this.rate,
      required this.is_active});

  factory DoctorDetails.fromJson(jsonData) {
    List<String?> days = [];

    for (int index = 0; index < jsonData['schedule'].length; index++) {
      days.add(jsonData['schedule'][index]['day']);
    }
    return DoctorDetails(
        reviews_count: jsonData['review_count'],
        bio: jsonData['bio'],
        fee: jsonData['consultation_fee'],
        rate: (jsonData['rate'] as num).toDouble(),
        workingDays: days,
        is_active: jsonData['is_active'] ?? true);
  }
}
