package io.flutter.embedding.android

import android.app.Activity

class ExclusiveAppComponentRegistry {
    private object Holder {
        val instance = ExclusiveAppComponentRegistry()
    }

    companion object {
        @JvmStatic
        val instance: ExclusiveAppComponentRegistry by lazy { Holder.instance }
    }

    private val exclusiveActivityForEngineMap: MutableMap<String, ExclusiveAppComponent<Activity>> =
            mutableMapOf()

    fun attachToActivity(
        cachedEngineId: String,
        exclusiveActivity: ExclusiveAppComponent<Activity>
    ) {
        exclusiveActivityForEngineMap[cachedEngineId]?.detachFromFlutterEngine()

        exclusiveActivityForEngineMap[cachedEngineId] = exclusiveActivity
    }

    fun detachFromActivity(cachedEngineId: String) {
        exclusiveActivityForEngineMap.remove(cachedEngineId)
    }
}