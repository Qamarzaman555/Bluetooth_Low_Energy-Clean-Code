import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/ble_controller.dart';
import 'device_connection_status.dart';

class DeviceListScreen extends StatelessWidget {
  const DeviceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BluetoothController controller = Get.find();
    return Scaffold(
      appBar: AppBar(title: const Text('Available Devices')),
      body: Obx(() {
        if (controller.scanResults.isEmpty) {
          return const Center(child: Text('No devices found'));
        } else {
          return ListView.builder(
            itemCount: controller.scanResults.length,
            itemBuilder: (context, index) {
              final device = controller.scanResults[index].device;
              return ListTile(
                title: Text(device.platformName.isEmpty
                    ? 'Unknown Device'
                    : device.platformName),
                subtitle: Text(device.remoteId.toString()),
                onTap: () {
                  controller.connectToDevice(device);
                  Get.to(const DeviceConnectionScreen());
                },
              );
            },
          );
        }
      }),
    );
  }
}
