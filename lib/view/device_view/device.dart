<<<<<<< HEAD
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
=======
// class DevicePage extends StatefulWidget {
//   final List<DeviceModel> devices;

//   const DevicePage({super.key, required this.devices});

//   @override
//   _DevicePageState createState() => _DevicePageState();
// }

// class _DevicePageState extends State<DevicePage> {
//   late List<DeviceModel> devices;

//   @override
//   void initState() {
//     super.initState();
//     devices = widget.devices;
//   }

//   void toggleDevice(int index, bool newValue) {
//     setState(() {
//       devices[index] = DeviceModel(
//         id: devices[index].id,
//         name: devices[index].name,
//         isConnected: devices[index].isConnected,
//         isOn: newValue,
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Device List'),
//         backgroundColor: Colors.blueGrey,
//         centerTitle: true,
//       ),
//       body: devices.isEmpty
//           ? const Center(child: Text('No devices available'))
//           : ListView.builder(
//               itemCount: devices.length,
//               itemBuilder: (context, index) {
//                 final device = devices[index];
//                 return Card(
//                   margin:
//                       const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                   child: ListTile(
//                     leading: CircleAvatar(
//                       backgroundColor:
//                           device.isConnected ? Colors.green : Colors.red,
//                       child: Icon(
//                         device.isOn ? Icons.power : Icons.power_off,
//                         color: Colors.white,
//                       ),
//                     ),
//                     title: Text(device.name,
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         )),
//                     subtitle: Text('ID: ${device.id}'),
//                     trailing: Switch(
//                       value: device.isOn,
//                       onChanged: (value) {
//                         if (device.isConnected) {
//                           toggleDevice(index, value);
//                         }
//                       },
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
>>>>>>> b2d3443e221efe9316de5882c82364eb2afa65eb
