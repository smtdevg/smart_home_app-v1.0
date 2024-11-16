import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  static String routeName = '/notification_page';

  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text('Notification'),
      ),
      body: const Center(
        child: Text(
          'No Notification',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
