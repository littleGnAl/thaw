# thaw
[![Build Status](https://api.cirrus-ci.com/github/littleGnAl/thaw.svg)](https://cirrus-ci.com/github/littleGnAl/thaw) 
[![pub package](https://img.shields.io/pub/v/thaw.svg)](https://pub.dev/packages/thaw)

A single-cache `FlutterEngine` solution for the [Add-to-app](https://flutter.dev/docs/development/add-to-app) scenario.

If you have experience with [Add-to-app](https://flutter.dev/docs/development/add-to-app) scenario, you may know that attaching a single-cache `FlutterEngine` to multiple `FlutterActivity`/`FlutterFragment` will cause the UI to freeze, which is described in this [issue](https://github.com/flutter/flutter/issues/49950) and the problem also appears in iOS. ***thaw*** was created to solve this problem.

Based on thaw, you can implement your own hybrid navigation framework more easily.

## Usage
***thaw*** provides `ThawFlutterActivity`/`ThawFlutterFragmentActivity`/`ThawFlutterFragment`/`ThawFlutterViewController`, which usage is the same as `FlutterActivity`/`FlutterFragmentActivity`/`FlutterFragment`/`FlutterViewController`, e.g., 

create a `ThawFlutterActivity`/`ThawFlutterFragment` in Android

```kotlin
ThawFlutterActivity.withCachedEngine("cache_engine").build()

ThawFlutterFragment.withCachedEngine("cache_engine").build()
```

create a `ThawFlutterViewController` in iOS

```swift
let flutterEngine = FlutterEngine(name: "cache_engine")
flutterEngine.run()
let viewController = ThawFlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
```

## License
    BSD 3-Clause License

    Copyright (c) 2020, Littlegnal
    All rights reserved.

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are met:

    1. Redistributions of source code must retain the above copyright notice, this
    list of conditions and the following disclaimer.

    2. Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.

    3. Neither the name of the copyright holder nor the names of its
    contributors may be used to endorse or promote products derived from
    this software without specific prior written permission.

