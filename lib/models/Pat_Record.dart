class PatRecord {
  int report_id;
  String? date;
  String? report_title;
  PatRecord({required this.report_id, this.date, this.report_title});
  factory PatRecord.fromJson(json) {
    return PatRecord(
        report_id: json['id'], date: json['date'], report_title: json['title']);
  }
}
