import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lango_launcher/launcher_controller.dart';

import 'launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(LauncherController());
    LauncherController().init();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Launcher(),
    );
  }
}
