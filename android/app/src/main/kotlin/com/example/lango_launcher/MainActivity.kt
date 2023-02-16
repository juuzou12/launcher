package com.example.lango_launcher

import android.app.DownloadManager
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.widget.Toast
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity: FlutterActivity() {
    private val CHANNEL = "launcher"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "download") {
                result.success(boardcastFunction())
            }
        }
    }

    fun boardcastFunction(){
        val br: BroadcastReceiver = object : BroadcastReceiver() {
            override fun onReceive(context: Context, intent: Intent) {
                println("action is " + intent.action)
                if (intent.action == Intent.ACTION_PACKAGE_REMOVED) {
                    val packageName = intent.data.toString()
                    val packageManager = context.packageManager
                    var packageInfo: PackageInfo? = null
                    println("package removed")
                    try {
                        packageInfo = packageManager.getPackageInfo(packageName, 0)
                    } catch (e: PackageManager.NameNotFoundException) {
                        e.printStackTrace()
                    }
                    assert(packageInfo != null)
                    Log.v("debug", packageInfo!!.versionName)
                }
                else if (intent.action == Intent.ACTION_PACKAGE_FULLY_REMOVED) {
                    val packageName = intent.data.toString().substring(8)
                    println("package removed $packageName")
                    //TODO update in UI
                    addAppsToUI()
                }
                else if (intent.action == Intent.ACTION_PACKAGE_ADDED) {
                    //String packageName = intent.getData().toString().substring(8);
                    println("package added ")
                    //TODO update in UI
                    addAppsToUI()
                }

                else if (intent.action == Intent.ACTION_PACKAGE_INSTALL) {
                    println("package installed")
                    //TODO update in UI
                }else if(intent.action=="com.example.action.SEND_APP_INFO_TO_LAUNCHER"){
                    println("intent received")
                }
            }
        }
    }

}
