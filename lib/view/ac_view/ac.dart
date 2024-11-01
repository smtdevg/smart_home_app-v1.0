import 'package:flutter/material.dart';

class ACPage extends StatelessWidget {
  static String routeName = '/ac-page';

  const ACPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AC Control'),
      ),
      body: Center(
        child: const Text(
          'This is the AC Page',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
