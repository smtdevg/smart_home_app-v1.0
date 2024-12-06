class DeviceModel {
  final String id; // ID của thiết bị
  final String name; // Tên thiết bị
  final String type; // Loại thiết bị (aircon, lock, switch, socket)
  final String room; // Phòng của thiết bị
  final Map<String, dynamic> status; // Trạng thái thiết bị dưới dạng Map
  final String icon; // Icon của thiết bị

  DeviceModel({
    required this.id,
    required this.name,
    required this.type,
    required this.room,
    required this.status,
    required this.icon,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json, String type) {
    dynamic rawStatus = json['status'];

    // Xử lý nếu `status` không phải là Map
    final status = rawStatus is Map<String, dynamic>
        ? rawStatus // Nếu là Map, giữ nguyên
        : {'on': rawStatus ?? false}; // Nếu là bool hoặc null, chuyển thành Map

    return DeviceModel(
      id: json['_id'].toString(),
      name: json['name'] ?? 'Unknown Device',
      type: type,
      room: json['room'] ?? 'Unknown Room',
      status: status,
      icon: _getIconPath(type),
    );
  }

  // Đường dẫn icon tương ứng với loại thiết bị
  static String _getIconPath(String type) {
    switch (type.toLowerCase()) {
      case 'airconditioner':
        return 'assets/svg/ac.svg';
      case 'lock':
        return 'assets/svg/lock.svg';
      case 'switch':
        return 'assets/svg/light.svg';
      case 'socket':
        return 'assets/svg/socket.svg';
      default:
        return 'assets/svg/default.svg';
    }
  }

  // Lấy trạng thái boolean cụ thể từ `status`
  bool get isOn {
    if (type.toLowerCase() == 'airconditioner') {
      return status['on'] ?? false; // AirConditioner dùng `on`
    } else if (type.toLowerCase() == 'lock') {
      return status['button'] ?? false; // Lock dùng `button`
    } else if (type.toLowerCase() == 'switch') {
      return status['button1'] ?? false; // Switch dùng `button1`
    } else if (type.toLowerCase() == 'socket') {
      return status['on'] ?? false; // Socket dùng `on`
    } else {
      return false;
    }
  }
}
