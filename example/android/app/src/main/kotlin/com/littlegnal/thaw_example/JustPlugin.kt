package com.littlegnal.thaw_example

import android.app.Activity
import io.flutter.embedding.android.FlutterActivityLaunchConfigs
import io.flutter.embedding.android.ThawFlutterActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodChannel

class JustPlugin : FlutterPlugin, ActivityAware {

    private var attachedToActivity: Activity? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        MethodChannel(binding.binaryMessenger, "just_channel").apply {
            setMethodCallHandler { call, result ->
                when (call.method) {
                    "start_flutter_activity" -> {
                        attachedToActivity?.apply {
                            startActivity(
                                ThawFlutterActivity.withCachedEngine("cache_engine")
                                        .backgroundMode(FlutterActivityLaunchConfigs.BackgroundMode.transparent)
                                        .build(this)
                            )
                        }

                        result.success(true)
                    }
                    "finish_activity" -> {
                        attachedToActivity?.apply {
                            finish()
                        }

                        result.success(true)
                    }
                    else -> result.notImplemented()
                }
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {

    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        attachedToActivity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        attachedToActivity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        attachedToActivity = binding.activity
    }

    override fun onDetachedFromActivity() {
        attachedToActivity = null
    }
}