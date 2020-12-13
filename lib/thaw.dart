
import 'dart:async';

import 'package:flutter/services.dart';

class Thaw {
  static const MethodChannel _channel =
      const MethodChannel('thaw');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
