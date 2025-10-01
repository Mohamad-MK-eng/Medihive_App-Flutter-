class Wallettransactions {
  int serial;
  String date;
  String time;
  String ammount;
  String type;
  int lastPage;
  String? doctor_name;
  String? clinic;
  String? charged_by;

  Wallettransactions({
    required this.serial,
    required this.date,
    required this.time,
    required this.ammount,
    required this.type,
    required this.lastPage,
    this.clinic,
    this.doctor_name,
    this.charged_by,
  });
  bool get isDeposit => type == 'deposit';
  bool get isPayment => type == 'payment';
  factory Wallettransactions.fromJosn(jsonData, last_page) {
    return Wallettransactions(
        serial: jsonData['id'],
        date: jsonData['date'],
        time: jsonData['time'],
        ammount: jsonData['amount'],
        type: jsonData['type'],
        clinic: jsonData['clinic_name'],
        doctor_name: jsonData['doctor_name'],
        charged_by: jsonData['charged_by'],
        lastPage: last_page);
  }
}
