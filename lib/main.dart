import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lango_launcher/launcher_controller.dart';

import 'launcher.dart';

void main() {
  initForLauncher();
  runApp(const MyApp());
}
void initForLauncher()async{
  // Create a platform channel
  const platform = const MethodChannel('launcher');

// Call the method on the Java side
  Future<String> result = await platform.invokeMethod('download');

// Receive the result in the Flutter code
  print(result);
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
