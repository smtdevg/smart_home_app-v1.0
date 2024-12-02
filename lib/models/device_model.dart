
class DeviceModel {
  final String id;
  final String name;
  final String type;
  final bool status;
  final bool isFav;

  DeviceModel({
    required this.id,
    required this.name,
    required this.type,
    required this.status,
    required this.isFav,
  });

  // Phương thức factory để tạo đối tượng từ JSON
  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    return DeviceModel(
      id: json['_id'],
      name: json['name'],
      type: json['typeDevice'],
      status: json['status']['button1'] ?? false,  // Tùy thuộc vào kiểu thiết bị
      isFav: false,  // Mặc định không phải yêu thích
    );
  }
}

