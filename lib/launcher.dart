import 'dart:convert';
import 'dart:io';

import 'package:analog_clock/analog_clock.dart';
import 'package:app_launcher/app_launcher.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:get/get.dart';
import 'package:installed_apps/app_info.dart';
import 'package:lango_launcher/text_widget.dart';

import 'launcher_controller.dart';

class Launcher extends GetView<LauncherController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff0A5CFE),
        body: Column(
          children: [
            Expanded(child: SizedBox(
              child: Image.asset("assets/Lango_original_logo.png",width: 200,),
            )),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, crossAxisSpacing: 8.0),
                      itemCount: controller.apps.length,
                      itemBuilder: (BuildContext context, int index) {
                        Application application;
                        return InkWell(
                            child: Column(
                              children: [
                                Image.memory(controller.apps[index].icon!,width: 30,height: 30,),
                                TextWidget(
                                  color: 0xff000000,
                                  fontWeight: FontWeight.w500,
                                  textAlign: TextAlign.center,
                                  fontSize: 12,
                                  text: controller.apps[index].name!,
                                ),
                              ],
                            ),
                            onTap: ()async{
                              await AppLauncher.openApp(
                                androidApplicationId: controller.apps[index].packageName!,
                              );
                            }
                        );
                      }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
