package com.singhsaubhik.cryptokeep

import android.util.Log
import android.view.WindowManager
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

const val CHANNEL = "com.singhsaubhik.cryptokeep/screencatpure"

class MainActivity : FlutterFragmentActivity(), MethodChannel.MethodCallHandler {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        val channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL);
        channel.setMethodCallHandler(this)
    }

    fun disableScreenCapture() {
        try {

            window.setFlags(
                    WindowManager.LayoutParams.FLAG_SECURE,
                    WindowManager.LayoutParams.FLAG_SECURE
            )
        } catch (e: Exception) {
            Log.e("MAIN", "Unable to set the flag")
        }
    }

    fun enableScreenCapture() {
        try {
            window.clearFlags(WindowManager.LayoutParams.FLAG_SECURE)
        } catch (e: Exception) {
            Log.e("MAIN", "Unable to set the flag")
        }
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if (call.method == "disableScreenCapture") {
            disableScreenCapture()
            result.success(1)
        }
    }
}