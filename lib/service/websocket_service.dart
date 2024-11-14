import 'dart:convert';
import 'package:app_smart_home/provider/server.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  // String serverAddress = Provider.of<ServerAddressProvider>(context).serverAddress;
  final WebSocketChannel channel = WebSocketChannel.connect(
    Uri.parse('ws://192.168.30.155:1901'),
  );

  void sendData(Map<String, dynamic> data) {
    final jsonData = jsonEncode(data);
    channel.sink.add(jsonData);
  }

  Stream<dynamic> get stream => channel.stream.map((data) => jsonDecode(data));

  void dispose() {
    channel.sink.close();
  }
}
