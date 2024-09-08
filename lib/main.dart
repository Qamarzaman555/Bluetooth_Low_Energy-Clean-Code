import 'package:flutter/material.dart';

import 'app/app.dart';
import 'app/di.dart';

void main() async {
  await di();
  runApp(const MyApp());
}
