import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import '../controller/ble_controller.dart';
import '../widgets/bluetooth_offscreen.dart';
import '../widgets/device_list.dart';

class BluetoothCheckScreen extends StatelessWidget {
  const BluetoothCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BluetoothController controller = Get.find();
    return Obx(() {
      if (controller.bluetoothState.value == BluetoothAdapterState.unknown) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      } else if (controller.bluetoothState.value == BluetoothAdapterState.on) {
        return const BluetoothOnScreen();
      } else {
        return const BluetoothOffScreen();
      }
    });
  }
}

class BluetoothOnScreen extends StatelessWidget {
  const BluetoothOnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BluetoothController controller = Get.find();
    return Scaffold(
      appBar: AppBar(title: const Text('Bluetooth On')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            controller.scanForDevices();
            Get.to(const DeviceListScreen());
          },
          child: const Text('Scan for Devices'),
        ),
      ),
    );
  }
}
