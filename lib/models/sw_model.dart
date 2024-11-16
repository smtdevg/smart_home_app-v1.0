class Device {
  final int id;
  final String name;
  final String typeDevice;
  final String room;
  final Status status;

  Device({
    required this.id,
    required this.name,
    required this.typeDevice,
    required this.room,
    required this.status,
  });

  // Chuyển đổi từ JSON sang object
  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['_id'],
      name: json['name'],
      typeDevice: json['typeDevice'],
      room: json['room'],
      status: Status.fromJson(json['status']),
    );
  }

  // Chuyển đổi từ object sang JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'typeDevice': typeDevice,
      'room': room,
      'status': status.toJson(),
    };
  }
}

class Status {
  final bool button1;
  final bool button2;

  Status({
    required this.button1,
    required this.button2,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      button1: json['button1'],
      button2: json['button2'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'button1': button1,
      'button2': button2,
    };
  }
}
