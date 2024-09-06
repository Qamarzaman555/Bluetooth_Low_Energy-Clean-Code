import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/ble_controller.dart';

class DeviceConnectionScreen extends StatelessWidget {
  const DeviceConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BluetoothController controller = Get.find();
    return Scaffold(
      appBar: AppBar(title: const Text('Device Connection')),
      body: Center(
        child: Obx(
          () => controller.isConnected.value != true
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        'Connected to device ${controller.connectedDevice?.platformName}',
                        style: const TextStyle(fontSize: 24)),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        controller.disconnectDevice();
                        Get.back();
                      },
                      child: const Text('Disconnect'),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
