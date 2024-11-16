import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  final String socketUrl;
  late WebSocketChannel channel;

  WebSocketService(this.socketUrl) {
    channel = WebSocketChannel.connect(Uri.parse(socketUrl));
  }

  // Gửi trạng thái thiết bị qua WebSocket
  void sendDeviceStatus(Map<String, dynamic> model) {
    final json = jsonEncode(model);
    channel.sink.add(json);
    print("Sent via WebSocket: $json");
  }

  // Nhận phản hồi từ server
  void listenToUpdates(Function(dynamic) onMessage) {
    channel.stream.listen((data) {
      final message = jsonDecode(data);
      print("Received via WebSocket: $message");
      onMessage(message);
    });
  }

  // Đóng WebSocket
  void close() {
    channel.sink.close();
  }
}
