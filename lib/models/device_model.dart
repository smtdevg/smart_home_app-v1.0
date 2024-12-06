class DeviceModel {
  final String id;
  final String name;
  final String type;
  final String room;
  final Map<String, dynamic> status;
  final String icon;

  DeviceModel({
    required this.id,
    required this.name,
    required this.type,
    required this.room,
    required this.status,
    required this.icon,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json, String endpoint) {
    final typeMapping = {
      'aircon': 'AirConditioner',
      'lock': 'Lock',
      'switch': 'Switch',
      'socket': 'Socket',
    };

    return DeviceModel(
      id: json['_id'].toString(),
      name: json['name'] ?? 'Unknown Device',
      type: typeMapping[endpoint] ?? endpoint,
      room: json['room'] ?? 'Unknown Room',
      status: json['status'] ?? {},
      icon: _getIconPath(typeMapping[endpoint] ?? endpoint),
    );
  }

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
}
