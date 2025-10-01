class Clinic {
  int id;
  String name;
  String imagePath;

  Clinic({required this.id, required this.name, required this.imagePath});

  factory Clinic.fromJson(jsonData) {
    return Clinic(
        id: jsonData['id'],
        name: jsonData['name'],
        imagePath: jsonData['icon_url'] ?? jsonData['image_path']);
  }
}
