// The original license from Flutter team:
// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Redistribution under:
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

package io.flutter.embedding.android;

import androidx.annotation.NonNull;

/**
 * An Android App Component exclusively attached to a {@link
 * io.flutter.embedding.engine.FlutterEngine}.
 *
 * <p>An exclusive App Component's {@link #detachFromFlutterEngine} is invoked when another App
 * Component is becoming attached to the {@link io.flutter.embedding.engine.FlutterEngine}.
 *
 * <p>The term "App Component" refer to the 4 component types: Activity, Service, Broadcast
 * Receiver, and Content Provider, as defined in
 * https://developer.android.com/guide/components/fundamentals.
 *
 * @param <T> The App Component behind this exclusive App Component.
 */
public interface ExclusiveAppComponent<T> {
    /**
     * Called when another App Component is about to become attached to the {@link
     * io.flutter.embedding.engine.FlutterEngine} this App Component is currently attached to.
     *
     * <p>This App Component's connections to the {@link io.flutter.embedding.engine.FlutterEngine}
     * are still valid at the moment of this call.
     */
    void detachFromFlutterEngine();

    /** Retrieve the App Component behind this exclusive App Component. */
    @NonNull
    T getAppComponent();
}
