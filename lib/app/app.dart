// import 'package:ble/app/di.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../routing/pages.dart';
import '../routing/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // initialBinding: GeneralBindings(),
      initialRoute: Routes.home,
      getPages: RoutePages.routes,
    );
  }
}
