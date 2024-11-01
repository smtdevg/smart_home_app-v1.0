class SwitchModel {
  final String id;
  final String name;
  final String typeDevice;
  final String room;
  bool status;

  SwitchModel({
    required this.id,
    required this.name,
    required this.typeDevice,
    required this.room,
    required this.status,
  });

  // Phương thức chuyển đổi từ JSON sang SwitchModel
  factory SwitchModel.fromJson(Map<String, dynamic> json) {
    return SwitchModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      typeDevice: json['typeDevice'] ?? '',
      room: json['room'] ?? '',
      status: json['status'] ?? false,
    );
  }

  // Phương thức chuyển đổi từ SwitchModel sang JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'typeDevice': typeDevice,
      'room': room,
      'status': status,
    };
  }

  @override
  String toString() {
    return 'SwitchModel{id: $id, name: $name, typeDevice: $typeDevice, room: $room, status: $status}';
  }
}
