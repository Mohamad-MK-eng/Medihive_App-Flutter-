class DoctorProfile {
  String first_name;
  String last_name;
  String specialty;
  String email;
  String phone_num;
  String? gender;
  String? address;
  List<String?> workingDays;
  String? start_working_data;
  String? image_path;
  String? clinic_name;
  int? experience_years;
  int? reviews_count;
  String? bio;
  String? fee;
  String? rate;
  bool is_active;

  DoctorProfile({
    required this.first_name,
    required this.last_name,
    required this.specialty,
    required this.email,
    required this.phone_num,
    required this.is_active,
    this.gender,
    required this.workingDays,
    this.start_working_data,
    this.image_path,
    this.clinic_name,
    this.experience_years,
    this.reviews_count,
    this.bio,
    this.fee,
    this.rate,
    this.address,
  });

  // ✅ Factory Constructor (fromJson)
  factory DoctorProfile.fromJson(Map<String, dynamic> json) {
    List<String?> days = [];

    for (int index = 0; index < json['working_days'].length; index++) {
      days.add(json['working_days'][index]['day']);
    }
    return DoctorProfile(
        first_name: json['first_name'],
        last_name: json['last_name'],
        specialty: json['specialty'],
        email: json['email'],
        phone_num: json['phone_number'],
        gender: json['gender'],
        workingDays: days,
        start_working_data: json['start_working_date'],
        image_path: json['profile_picture_url'],
        clinic_name: json['clinic'],
        experience_years: json['experience_years'],
        reviews_count: json['rating_count'],
        bio: json['bio'],
        fee: json['consultation_fee'],
        rate: json['rating'].toString(),
        address: json['address'],
        is_active: json['is_active']);
  }
}
