class Prescription {
  String drug;
  String? dose;
  String? repeate;
  String? notes;
  Prescription(
      {required this.drug,
      required this.dose,
      required this.repeate,
      required this.notes});

  factory Prescription.fromJson(jsonData) {
    return Prescription(
        drug: jsonData['medication'],
        dose: jsonData['dosage'],
        repeate: jsonData['frequency'],
        notes: jsonData['instructions']);
  }
  Map<String, String?> toMapElement() {
    return {
      'medication': drug,
      'dosage': dose,
      'frequency': repeate,
      'instructions': notes,
    };
  }
}
