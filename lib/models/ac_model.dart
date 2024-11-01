class AirconStatus {
  int mode;
  int fanSpeed;
  int temp;
  bool isOn;
  bool isSwing;

  AirconStatus({
    required this.mode,
    required this.fanSpeed,
    required this.temp,
    this.isOn = false,
    this.isSwing = false,
  });
}

class AirconModel {
  String name;
  AirconStatus status;

  AirconModel({required this.name, required this.status});
}
