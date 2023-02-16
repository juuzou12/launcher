import 'dart:async';
import 'dart:io';

import 'package:battery_info/battery_info_plugin.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:get/get.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:path_provider/path_provider.dart';

class LauncherController {
  LauncherController() {
    init();
  }

  Timer? timer;
  RxList apps = [].obs;
  RxDouble heightV=0.0.obs;
  RxInt appsLength = 0.obs;
  static const platform = const MethodChannel('launcher');
  Future<List> init() async {
    apps.value = await InstalledApps.getInstalledApps(true, true, "");
    try {
      final int result =
      await platform.invokeMethod('download');
      print('$result');
      timer = Timer.periodic(const Duration(seconds: 10), (Timer t) async=> {
        if(apps.length!=appsLength.value){
          apps.value = await InstalledApps.getInstalledApps(true, true, ""),
        }

      });
    } on PlatformException catch (e) {
      print('===============$e=================');
    }
    return apps;
  }


  Future<File> getLocalFile(String? filename) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File('$filename/');
    // print('$filename=====');
    return file;
  }

  String time(String month, String day, String year) {
    switch (month) {
      case "1":
        return "January - $day - $year";
    }
    return "";
  }

  Future<List<SmsMessage>> notifications() async {
    try {
      List<SmsMessage> messages = await SmsQuery().getAllSms;
      print("${messages[0].body}------");
      return messages;
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = await FlutterContacts.getContacts();
    print(contacts);
    return contacts;
  }

  Future<String?> batteryInfo(String value) async {
    switch (value) {
      case "temperature":
        return (await BatteryInfoPlugin().androidBatteryInfo)!
            .temperature
            .toString();
    }
  }
}
