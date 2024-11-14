import 'package:app_smart_home/provider/server.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_smart_home/config/size_config.dart';

class SettingPage extends StatefulWidget {
  static String routeName = '/setting_page';
  const SettingPage({super.key});

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  // Khai báo TextEditingController
  final TextEditingController _serverAddressController =
      TextEditingController();
  String _serverAddress = ''; // Biến để lưu địa chỉ server

  @override
  void dispose() {
    // Giải phóng controller khi không sử dụng nữa
    _serverAddressController.dispose();
    super.dispose();
  }

  void _saveServerAddress() {
    // Lưu giá trị từ TextField vào biến
    setState(() {
      _serverAddress = _serverAddressController.text; // Lưu địa chỉ server
    });

    // Hiển thị thông báo hoặc thực hiện hành động khác
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Địa chỉ server đã lưu: $_serverAddress')),
    );

    // Gán lại giá trị cho controller để hiển thị trong TextField
    _serverAddressController.text = _serverAddress;
    Provider.of<ServerAddressProvider>(context, listen: false)
        .setServerAddress(_serverAddress);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            toolbarHeight: getProportionateScreenHeight(50),
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
            title: Text('Network Setting'),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            child: Text('Server Address'),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: const Color(0xff1d1617).withOpacity(0.11),
                blurRadius: 40,
                spreadRadius: 0.0,
              ),
            ]),
            child: TextField(
              controller:
                  _serverAddressController, // Gán controller vào TextField
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: OutlinedButton(
              onPressed: _saveServerAddress, // Gọi hàm lưu khi nhấn button
              child: Text('Save'),
            ),
          ),
        ],
      ),
    );
  }
}
