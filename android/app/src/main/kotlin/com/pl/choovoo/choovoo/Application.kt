/*
package com.pl.choovoo.choovoo

import io.flutter.app.FlutterApplication
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService
import com.pl.choovoo.choovoo.FlutterLocalNotificationsPlugin


class Application : FlutterApplication(), PluginRegistrantCallback {
    override fun onCreate() {
        super.onCreate()
        FlutterFirebaseMessagingService.setPluginRegistrant(this)
    }

    override fun registerWith(registry: PluginRegistry?) {
       // GeneratedPluginRegistrant.registerWith((registry as FlutterEngine?)!!)
        if (!registry!!.hasPlugin("io.flutter.plugins.firebasemessaging")) {
            FirebaseMessagingPlugin.registerWith(registry!!.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"));
        }
        if (!registry!!.hasPlugin("com.pl.choovoo.choovoo")) {
            FlutterLocalNotificationsPlugin.registerWith(registry!!.registrarFor("com.pl.choovoo.choovoo.FlutterLocalNotificationsPlugin"));
        }
    }
}*/
