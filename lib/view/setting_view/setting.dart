import 'package:app_smart_home/view/setting_view/config.dart';
import 'package:flutter/material.dart';
import 'package:app_smart_home/config/size_config.dart';

class SettingPage extends StatefulWidget {
  static String routeName = '/setting_page';
  const SettingPage({super.key});

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final TextEditingController _ipController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadIpAddress();
  }

  Future<void> _loadIpAddress() async {
    // Lấy giá trị từ ConfigManager
    _ipController.text = ConfigManager().apiUrl.split("//")[1].split(":")[0];
  }

  void _saveIpAddress() async {
    final newIp = _ipController.text.trim();

    if (RegExp(r'^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$').hasMatch(newIp)) {
      // Cập nhật IP trong ConfigManager
      await ConfigManager().updateIpAddress(newIp);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cập nhật địa chỉ IP thành công!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập địa chỉ IP hợp lệ!')),
      );
    }
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
            title: const Text('Cài đặt mạng'),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            child: const Text('Địa chỉ IP'),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: const Color(0xff1d1617).withOpacity(0.11),
                blurRadius: 40,
                spreadRadius: 0.0,
              ),
            ]),
            child: TextField(
              controller: _ipController,
              decoration: InputDecoration(
                hintText: '192.168.x.x',
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
              onPressed: _saveIpAddress,
              child: const Text('Lưu'),
            ),
          ),
        ],
      ),
    );
  }
}
