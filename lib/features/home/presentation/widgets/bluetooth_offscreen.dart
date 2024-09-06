import 'package:flutter/material.dart';

class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Bluetooth is Off', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
