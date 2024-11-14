import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  static String routeName = '/notification_page';

  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: const Text('Notification'),
      ),
      body: Center(
        child: const Text(
          'No Notification',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
