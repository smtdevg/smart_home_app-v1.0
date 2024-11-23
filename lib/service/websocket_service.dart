import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

import '../view/setting_view/config.dart';

class WebSocketService {
  final String socketUrl =ConfigManager().websocketUrl;
  late WebSocketChannel channel;
  bool _isConnected = false;

  WebSocketService() {
    connect();
  }

  // Kết nối WebSocket
  void connect() {
    try {
      channel = WebSocketChannel.connect(Uri.parse(socketUrl));
      _isConnected = true;
      print('WebSocket connected to $socketUrl');
    } catch (e) {
      print('Failed to connect WebSocket: $e');
      _isConnected = false;
    }
  }

  // Gửi dữ liệu qua WebSocket
  void sendDeviceStatus(Map<String, dynamic> json) {
    if (_isConnected) {
      try {
        final jsonString = jsonEncode(json);
        channel.sink.add(jsonString);
        print('Sent via WebSocket: $jsonString');
      } catch (e) {
        print('Failed to send data: $e');
      }
    } else {
      print('WebSocket is not connected. Cannot send data.');
    }
  }

  // Lắng nghe dữ liệu từ server
  void listen(Function(Map<String, dynamic>) onMessage) {
    if (_isConnected) {
      channel.stream.listen(
            (data) {
          try {
            final decodedData = jsonDecode(data);
            print('Received via WebSocket: $decodedData');
            onMessage(decodedData);
          } catch (e) {
            print('Failed to decode WebSocket message: $e');
          }
        },
        onError: (error) {
          print('WebSocket error: $error');
          _isConnected = false;
        },
        onDone: () {
          print('WebSocket connection closed.');
          _isConnected = false;
        },
      );
    } else {
      print('WebSocket is not connected. Cannot listen.');
    }
  }

  // Đóng WebSocket
  void close() {
    if (_isConnected) {
      try {
        channel.sink.close(status.goingAway);
        print('WebSocket connection closed.');
      } catch (e) {
        print('Failed to close WebSocket: $e');
      }
    } else {
      print('WebSocket is not connected. No need to close.');
    }
  }
}
