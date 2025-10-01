class Doctorappointment {
  int patientId;
  int appointmentId;
  String patientName;
  String? phone;
  String time;
  String date;
  String? imageUrl;

  Doctorappointment({
    required this.patientId,
    required this.appointmentId,
    required this.patientName,
    required this.phone,
    required this.time,
    required this.imageUrl,
    required this.date,
  });
  factory Doctorappointment.fromJosn(json) {
    return Doctorappointment(
        patientId: json['patient_id'],
        appointmentId: json['appointment_id'],
        patientName: json['first_name'] + ' ' + json['last_name'],
        phone: json['phone_number'],
        time: json['time'],
        date: json['date'],
        imageUrl: json['image']);
  }
}
