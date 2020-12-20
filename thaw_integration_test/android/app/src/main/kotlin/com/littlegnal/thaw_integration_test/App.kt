package com.littlegnal.thaw_integration_test

import android.app.Application
import io.flutter.app.FlutterApplication
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor

class App : FlutterApplication() {

    override fun onCreate() {
        super.onCreate()

        val flutterEngine = FlutterEngine(applicationContext)
        flutterEngine.navigationChannel.setInitialRoute("/")
        flutterEngine.dartExecutor
            .executeDartEntrypoint(DartExecutor.DartEntrypoint.createDefault())
        FlutterEngineCache.getInstance().put("cache_engine", flutterEngine)
        flutterEngine.plugins.add(JustPlugin())
    }
}