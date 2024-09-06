import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothController extends GetxController {
  var bluetoothState = BluetoothAdapterState.unknown.obs;
  var scanResults = <ScanResult>[].obs;
  RxBool isConnected = false.obs;
  BluetoothDevice? connectedDevice;

  @override
  void onInit() {
    super.onInit();
    _checkBluetoothState();
  }

  // Check for necessary permissions
  Future<void> _checkPermissions() async {
    await [
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.location, // BLE scanning often requires location permission
    ].request();
  }

  void _checkBluetoothState() {
    FlutterBluePlus.adapterState.listen((state) {
      bluetoothState.value = state;
      _checkPermissions();
    });
  }

  Future<void> scanForDevices() async {
    // Request location permission if not granted
    if (await Permission.location.request().isGranted) {
      FlutterBluePlus.startScan(timeout: const Duration(seconds: 4));

      // Listen to scan results
      FlutterBluePlus.scanResults.listen((results) {
        scanResults.value = results;
      });
    } else {
      Get.snackbar('Permission Denied',
          'Location permission is required to scan for devices');
    }
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      if (isConnected.value) {
        disconnectDevice();
      }
      await device.connect();
      connectedDevice = device;
      isConnected.value = true;

      // Optionally, stop scanning once a device is connected
      stopScan();
    } catch (e) {
      Get.back();
      Get.snackbar('Connection Error', 'Failed to connect to device');
    }
  }

  void stopScan() {
    FlutterBluePlus.stopScan();
  }

  Future<void> disconnectDevice() async {
    if (connectedDevice != null) {
      await connectedDevice!.disconnect();
      isConnected.value = false;
      connectedDevice = null;
    }
  }
}
