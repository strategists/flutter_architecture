// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_architecture/app.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(App());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  test('Create Observable from Future', () async {
    print('start');
    Observable.fromFuture(asyncFunction())
        .doOnListen(() {
          print('doOnListen');
        })
        .doOnData((onData) => print("doOnData :$onData"))
        .doOnError((error) {
          print('doOnError $error');
        })
        .doOnDone(() {
          print('doOnDone');
        })
        .listen((onData) => print('listen: $onData'));
  });

  test("create observable", () {
    //创建一条处理int类型的流
    StreamController<int> numController = StreamController();
//    numController.stream.listen((onData) => print("stream onData $onData"));
    Observable(numController.stream)
        .doOnData((onData) => print("Observable doOnData: $onData"))
        .listen((onData) => print("Observable onData$onData"));
    numController.sink.add(123);
  });
}

Future<String> asyncFunction() async {
//  return Future.delayed(const Duration(seconds: 1), () => "AsyncRsult");
  return Future.value("hello ever one");
}
