class DoctorPatient {
  int patinet_id;
  String full_name;
  String? phone_number;
  String? patient_image;
  String last_visit_date; // maybe nullable
  DoctorPatient(
      {required this.patinet_id,
      required this.full_name,
      required this.phone_number,
      required this.last_visit_date,
      required this.patient_image});

  factory DoctorPatient.fromJson(json) {
    return DoctorPatient(
        patinet_id: json['patient_id'],
        full_name: json['patient_name'],
        phone_number: json['phone'],
        last_visit_date: json['last_visit_at'],
        patient_image: json['profile_picture_url']);
  }
}
