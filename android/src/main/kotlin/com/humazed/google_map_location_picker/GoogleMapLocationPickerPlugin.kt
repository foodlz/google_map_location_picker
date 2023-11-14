package com.humazed.google_map_location_picker

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import android.content.pm.PackageManager
import java.math.BigInteger
import java.security.MessageDigest
import android.content.pm.PackageInfo

class GoogleMapLocationPickerPlugin : FlutterPlugin, MethodCallHandler, ActivityAware  {
    private lateinit var channel : MethodChannel
    private var activityBinding: ActivityPluginBinding? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "google_map_location_picker")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if(activityBinding == null) {
            result.error("ERROR", "Activity binding is null", null)
            return
        }
        if (call.method == "getSigningCertSha1") {
            try {
                val packageName = call.arguments<String>()?.takeIf { it.isNotBlank() } ?: run {
                    result.error("ERROR", "Package name is null or blank", null)
                    return
                }

                val binding = activityBinding
                if (binding != null) {
                    val info: PackageInfo? = binding.activity.packageManager.getPackageInfo(packageName, PackageManager.GET_SIGNATURES)

                    if (info != null) {
                        for (signature in info.signatures) {
                            val md: MessageDigest = MessageDigest.getInstance("SHA1")
                            md.update(signature.toByteArray())

                            val bytes: ByteArray = md.digest()
                            val bigInteger = BigInteger(1, bytes)
                            val hex: String = String.format("%0" + (bytes.size shl 1) + "x", bigInteger)

                            result.success(hex)
                        }
                    } else {
                        result.error("ERROR", "Package info is null", null)
                    }
                } else {
                    result.error("ERROR", "Activity binding is null", null)
                }
            } catch (e: Exception) {
                result.error("ERROR", e.toString(), null)
            }
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activityBinding = binding
    }

    override fun onDetachedFromActivity() {
        activityBinding = null
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    }
}
