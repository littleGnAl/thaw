// Copyright (c) 2020, Littlegnal
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice, this
// list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation
// and/or other materials provided with the distribution.
//
// 3. Neither the name of the copyright holder nor the names of its
// contributors may be used to endorse or promote products derived from
// this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

package com.littlegnal.thaw_example

import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.AppCompatButton
import androidx.fragment.app.Fragment
import io.flutter.Log
import io.flutter.embedding.android.FlutterFragment
import io.flutter.embedding.android.RenderMode
import io.flutter.embedding.android.ThawFlutterFragment
import io.flutter.embedding.android.TransparencyMode

class MainActivity: AppCompatActivity() {

    companion object {
        private const val TAG_FLUTTER_FRAGMENT = "flutter_fragment"
    }

    private var flutterFragment: FlutterFragment? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        Log.setLogLevel(android.util.Log.VERBOSE)
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        // Start a new FlutterFragment which host by MainActivity
        findViewById<AppCompatButton>(R.id.btnAddActivity).setOnClickListener {
            startActivity(Intent(this, MainActivity::class.java))
        }

        // Finish MainActivity
        findViewById<AppCompatButton>(R.id.btnFinishActivity).setOnClickListener {
            finish()
        }

        flutterFragment = supportFragmentManager
                .findFragmentByTag(TAG_FLUTTER_FRAGMENT) as? FlutterFragment

        if (flutterFragment == null) {
            val ff: ThawFlutterFragment = ThawFlutterFragment
                    .withCachedEngine("cache_engine")
                    .transparencyMode(TransparencyMode.opaque)
                    .renderMode(RenderMode.texture)
                    .build()
            supportFragmentManager
                    .beginTransaction()
                    .add(
                        R.id.flFlutterFragment,
                        ff as Fragment,
                        TAG_FLUTTER_FRAGMENT
                    )
                    .commit()
        }
    }

    override fun onPostResume() {
        super.onPostResume()
        flutterFragment?.onPostResume()
    }

    override fun onNewIntent(intent: Intent) {
        flutterFragment?.onNewIntent(intent)
        super.onNewIntent(intent)
    }

    override fun onBackPressed() {
        flutterFragment?.onBackPressed()
    }

    override fun onRequestPermissionsResult(
            requestCode: Int,
            permissions: Array<String?>,
            grantResults: IntArray
    ) {
        flutterFragment?.onRequestPermissionsResult(
                requestCode,
                permissions,
                grantResults
        )
    }

    override fun onUserLeaveHint() {
        flutterFragment?.onUserLeaveHint()
    }

    override fun onTrimMemory(level: Int) {
        super.onTrimMemory(level)
        flutterFragment?.onTrimMemory(level)
    }
}
