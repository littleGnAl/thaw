package com.littlegnal.thaw_example

import android.app.Application
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor

class App : Application() {

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