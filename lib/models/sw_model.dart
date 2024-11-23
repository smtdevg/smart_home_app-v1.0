class SwitchModel {
  final int id;
  final String name;
  final String typeDevice;
  final String room;
  final SwitchStatusModel status;

  SwitchModel({
    required this.id,
    required this.name,
    required this.typeDevice,
    required this.room,
    required this.status,
  });

  factory SwitchModel.fromJson(Map<String, dynamic> json) {
    return SwitchModel(
      id: json['_id'],
      name: json['name'],
      typeDevice: json['typeDevice'],
      room: json['room'],
      status: SwitchStatusModel.fromJson(json['status']),
    );
  }

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

class SwitchStatusModel {
  final bool button1;
  final bool button2;

  SwitchStatusModel({
    required this.button1,
    required this.button2,
  });

  factory SwitchStatusModel.fromJson(Map<String, dynamic> json) {
    return SwitchStatusModel(
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
