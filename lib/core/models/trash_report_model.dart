class TrashReport {
  final int id;
  final int userId;
  final String description;
  final String category;
  final String imagePath;
  final double latitude;
  final double longitude;
  final int quantity;
  final String item;

  TrashReport({
    required this.id,
    required this.userId,
    required this.description,
    required this.category,
    required this.imagePath,
    required this.latitude,
    required this.longitude,
    required this.quantity,
    required this.item,
  });

  factory TrashReport.fromMap(Map<String, dynamic> map) {
    return TrashReport(
      id: map['id'],
      userId: map['user_id'],
      description: map['description'],
      category: map['category'],
      imagePath: map['image_path'],
      latitude: double.parse(map['latitude']),
      longitude: double.parse(map['longitude']),
      quantity: map['quantity'],
      item: map['item'],
    );
  }
}
