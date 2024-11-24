
import 'package:flutter/material.dart';

class DeviceSettingsPage extends StatefulWidget {
  static const routeName = '/device-settings';

  final String deviceId;
  final String deviceType;
  final String deviceName;

  const DeviceSettingsPage({
    Key? key,
    required this.deviceId,
    required this.deviceType,
    required this.deviceName,
  }) : super(key: key);

  @override
  _DeviceSettingsPageState createState() => _DeviceSettingsPageState();
}

class _DeviceSettingsPageState extends State<DeviceSettingsPage> {
  late TextEditingController _idController;
  late TextEditingController _typeController;
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController(text: widget.deviceId);
    _typeController = TextEditingController(text: widget.deviceType);
    _nameController = TextEditingController(text: widget.deviceName);
  }

  @override
  void dispose() {
    _idController.dispose();
    _typeController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _saveDeviceSettings() {
    final updatedId = _idController.text;
    final updatedType = _typeController.text;
    final updatedName = _nameController.text;

    // Thực hiện hành động lưu dữ liệu tại đây, ví dụ:
    print('Updated ID: $updatedId');
    print('Updated Type: $updatedType');
    print('Updated Name: $updatedName');

    // Hiển thị thông báo thành công
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Device settings updated successfully!')),
    );

    // Quay lại trang trước
    Navigator.pop(context, {
      'id': updatedId,
      'type': updatedType,
      'name': updatedName,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Edit Device Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _idController,
              decoration: const InputDecoration(
                labelText: 'Device ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _typeController,
              decoration: const InputDecoration(
                labelText: 'Device Type',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Device Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: _saveDeviceSettings,
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
