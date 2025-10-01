class AppDate {
  String fullDate;
  String day_number;
  String day_name;
  String month_name;
  AppDate(
      {required this.fullDate,
      required this.day_name,
      required this.day_number,
      required this.month_name});

  factory AppDate.fromJson(jsonData) {
    return AppDate(
        fullDate: jsonData['full_date'],
        day_name: jsonData['day_name'],
        day_number: jsonData['day_number'],
        month_name: jsonData['month']);
  }
}

class AppTime {
  int slot_id;
  String time;
  AppTime({required this.time, required this.slot_id});
  factory AppTime.fromJson(jsonData) {
    return AppTime(time: jsonData['time'], slot_id: jsonData['slot_id']);
  }
}

class AppDateTime {
  AppDate date;
  AppTime time;
  // ممكن اعمل هون fulldatetime يعني بهاد المودل يكون جاهز للأرسال فورا من نوع string
  AppDateTime({required this.date, required this.time});

  factory AppDateTime.fromJson(jsonData) {
    return AppDateTime(
        date: AppDate.fromJson(jsonData), time: AppTime.fromJson(jsonData));
  }
}
