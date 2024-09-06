import 'package:get/get.dart';

import '../features/home/presentation/view/home.dart';
import '../features/home/presentation/widgets/device_connection_status.dart';
import 'routes.dart';

class RoutePages {
  static const String home = '/';

  static final routes = [
    GetPage(name: Routes.home, page: () => const BluetoothCheckScreen()),
    GetPage(
        name: Routes.deviceConnection,
        page: () => const DeviceConnectionScreen())
  ];
}
