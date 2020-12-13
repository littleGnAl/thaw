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

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:thaw_integration_test/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Launch first screen", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets("Start a new flutter screen", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.text('Start A New Flutter Screen'));
    await tester.pumpAndSettle();

    // FIXME: When start a new flutter screen, the follow exception occur, but no exception occur on the real build.
    // I/flutter (25758): ══╡ EXCEPTION CAUGHT BY SCHEDULER LIBRARY ╞═════════════════════════════════════════════════════════
    // I/flutter (25758): The following assertion was thrown during a scheduler callback:
    // I/flutter (25758): Matrix4 entries must be finite.
    // I/flutter (25758): 'dart:ui/painting.dart':
    // I/flutter (25758): Failed assertion: line 50: '<optimized out>'
    // I/flutter (25758):
    // I/flutter (25758): Either the assertion indicates an error in the framework itself, or we should provide substantially
    // I/flutter (25758): more information in this error message to help you determine and fix the underlying cause.
    // I/flutter (25758): In either case, please report this assertion by filing a bug on GitHub:
    // I/flutter (25758):   https://github.com/flutter/flutter/issues/new?template=BUG.md
    // I/flutter (25758):
    // I/flutter (25758): When the exception was thrown, this was the stack:
    // I/flutter (25758): #2      _matrix4IsValid (dart:ui/painting.dart:50:10)
    // I/flutter (25758): #3      SceneBuilder.pushTransform (dart:ui/compositing.dart:279:12)
    // I/flutter (25758): #4      TransformLayer.addToScene (package:flutter/src/rendering/layer.dart:1607:27)
    // I/flutter (25758): #5      ContainerLayer.buildScene (package:flutter/src/rendering/layer.dart:767:5)
    // I/flutter (25758): #6      RenderView.compositeFrame (package:flutter/src/rendering/view.dart:231:37)
    // I/flutter (25758): #7      RendererBinding.drawFrame (package:flutter/src/rendering/binding.dart:440:18)
    // I/flutter (25758): #8      WidgetsBinding.drawFrame (package:flutter/src/widgets/binding.dart:914:13)
    // I/flutter (25758): #9      RendererBinding._handlePersistentFrameCallback (package:flutter/src/rendering/binding.dart:302:5)
    // I/flutter (25758): #10     SchedulerBinding._invokeFrameCallback (package:flutter/src/scheduler/binding.dart:1117:15)
    // I/flutter (25758): #11     SchedulerBinding.handleDrawFrame (package:flutter/src/scheduler/binding.dart:1055:9)
    // I/flutter (25758): #12     LiveTestWidgetsFlutterBinding.handleDrawFrame (package:flutter_test/src/binding.dart:1447:13)
    // I/flutter (25758): #13     SchedulerBinding._handleDrawFrame (package:flutter/src/scheduler/binding.dart:971:5)
    // I/flutter (25758): #17     _invoke (dart:ui/hooks.dart:251:10)
    // I/flutter (25758): #18     _drawFrame (dart:ui/hooks.dart:209:3)
    // I/flutter (25758): (elided 5 frames from class _AssertionError and dart:async)
    // I/flutter (25758): ════════════════════════════════════════════════════════════════════════════════════════════════════
    // I/flutter (25758): (If WidgetTester.takeException is called, the above exception will be ignored. If it is not, then the above exception will be dumped when another exception is caught by the framework or
    // when the test ends, whichever happens first, and then the test will fail due to having not caught or expected the exception.)
    await tester.takeException();

    // Delay 2 sceonds to make sure the new ThawFlutterActivity/ThawFlutterViewController has been shown.
    await Future.delayed(Duration(seconds: 2));

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    print('find 2');
    expect(find.text('2'), findsOneWidget);
  });

  testWidgets("Start a new flutter screen and finish it",
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.text('Start A New Flutter Screen'));
    await tester.pumpAndSettle();

    await tester.takeException();

    // Delay 2 sceonds to make sure the new ThawFlutterActivity/ThawFlutterViewController has been shown.
    await Future.delayed(Duration(seconds: 2));

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    print('find 2');
    expect(find.text('2'), findsOneWidget);

    await tester.tap(find.text('Finish Current Flutter Screen'));
    await tester.pumpAndSettle();

    // Delay 2 sceonds to make sure the first ThawFlutterActivity/ThawFlutterViewController has been shown.
    await Future.delayed(Duration(seconds: 2));

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    print('find 3');
    expect(find.text('3'), findsOneWidget);
  });

  testWidgets("Start two new flutter screen and finish them",
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.text('Start A New Flutter Screen'));
    await tester.pumpAndSettle();
    await tester.takeException();

    // Delay 2 sceonds to make sure the new ThawFlutterActivity/ThawFlutterViewController has been shown.
    await Future.delayed(Duration(seconds: 2));

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    print('find 2');
    expect(find.text('2'), findsOneWidget);

    await tester.tap(find.text('Start A New Flutter Screen'));
    await tester.pumpAndSettle();
    await tester.takeException();

    // Delay 2 sceonds to make sure the new ThawFlutterActivity/ThawFlutterViewController has been shown.
    await Future.delayed(Duration(seconds: 2));

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    print('find 3');
    expect(find.text('3'), findsOneWidget);

    await tester.tap(find.text('Finish Current Flutter Screen'));
    await tester.pumpAndSettle();

    // Delay 2 sceonds to make sure the first ThawFlutterActivity/ThawFlutterViewController has been shown.
    await Future.delayed(Duration(seconds: 2));

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    print('find 4');
    expect(find.text('4'), findsOneWidget);

    await tester.tap(find.text('Finish Current Flutter Screen'));
    await tester.pumpAndSettle();

    // Delay 2 sceonds to make sure the first ThawFlutterActivity/ThawFlutterViewController has been shown.
    await Future.delayed(Duration(seconds: 2));

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    print('find 5');
    expect(find.text('5'), findsOneWidget);
  });
}
