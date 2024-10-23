import 'package:flutter/material.dart';

class DropoffPage extends StatelessWidget {
  const DropoffPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dropoff'),
      ),
      body: Center(
        child: const Text(
          'Here is the dropoff page!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
