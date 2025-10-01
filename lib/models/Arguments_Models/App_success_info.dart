class AppSuccessInfo {
  String docotr_name;
  String clinic_name;
  String date;
  String time;
  AppSuccessInfo(
      {required this.clinic_name,
      required this.date,
      required this.docotr_name,
      required this.time});

  factory AppSuccessInfo.fromJson(jsonData) {
    final data = jsonData['appointment_details'];
    return AppSuccessInfo(
        clinic_name: data['clinic'],
        date: data['date'],
        docotr_name: data['doctor'],
        time: data['time']);
  }
}
