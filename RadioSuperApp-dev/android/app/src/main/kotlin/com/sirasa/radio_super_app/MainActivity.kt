package com.sirasa.radio_super_app

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.sirasa.radio_super_app/minimize"

    override fun configureFlutterEngine(flutterEngine: io.flutter.embedding.engine.FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "minimizeApp") {
                moveTaskToBack(true) // Minimize the app
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }
}