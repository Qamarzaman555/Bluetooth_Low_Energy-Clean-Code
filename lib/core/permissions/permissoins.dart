import 'dart:io';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class PermissionsStatusCheck {
  static bool isBluetoothOn = false;

  static Future<bool> check() async {
/**
 * just need to call this method and when return true all 
 * permissions are granted and bluetooth and location is turned on
 */

    bool serviceEnabled = await _enableLoc();
    bool checkBlueTooth = await _enableBT();

    if (Platform.isIOS) {
      if (serviceEnabled && checkBlueTooth) {
        return true;
      } else {
        await _enableLoc();
        return false;
      }
    } else {
      bool permissionGranted = await _permissionStatus();

      if (permissionGranted && serviceEnabled && checkBlueTooth) {
        return true;
      } else {
        return false;
      }
    }
  }

  static void initBleStateStream() {
/**
 * call this method in main file or when you initialize dependencies it should be done 
 * before calling the check method 
 */

    FlutterBluePlus.adapterState.listen((state) {
      if (state == BluetoothAdapterState.on) {
        isBluetoothOn = true;
      } else {
        isBluetoothOn = false;
      }
    });
  }

  static Future<bool> _enableLoc() async {
/**
 * We are using geolocator for all location things. If location is off it will go to the phone's
 * settings if it can otherwise show some response to user to turn it on and if user turn on this
 * will return true
 */

    bool enable = await Geolocator.isLocationServiceEnabled();
    if (enable) {
      return true;
    } else {
      bool request = await Geolocator.isLocationServiceEnabled();
      if (request) {
        return true;
      } else {
        // if settings retrun false show some toast or message to turn on location
        await Geolocator.openLocationSettings();
        return false;
      }
    }
  }

  static Future<bool> _enableBT() async {
    if (Platform.isAndroid) {
      if (isBluetoothOn) {
        return true;
      } else {
        try {
          await FlutterBluePlus.turnOn();
          return isBluetoothOn;
        } catch (e) {
          // show toast to turn on bluetooth
          return false;
        }
      }
    } else {
      if (isBluetoothOn) {
        return true;
      } else {
        // you can show toast message here
        return false;
      }
    }
  }

  static Future<bool> _permissionStatus() async {
    if (Platform.isAndroid) {
      bool allGranted = true;

      // add any permissions you needed in the app to this list
      Map<Permission, PermissionStatus> permissionsList = await [
        Permission.bluetoothScan,
        Permission.bluetoothConnect,
        Permission.location
      ].request();

      permissionsList.forEach((key, stat) {
        if (stat != PermissionStatus.granted) {
          allGranted = false;
        }
      });

      return allGranted;
    } else {
      return true;
    }
  }
}
