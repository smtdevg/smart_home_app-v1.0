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
