import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yamagata_live_camera/main.dart';

void main() {
  testWidgets('App starts and shows home screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const YamagataLiveCameraApp());

    // Verify that the app title is displayed
    expect(find.text('山形県ライブカメラ'), findsOneWidget);

    // Verify that the home screen content is displayed
    expect(find.text('山形県内のライブカメラと気象情報'), findsOneWidget);
  });

  testWidgets('Home screen displays region selector', (WidgetTester tester) async {
    await tester.pumpWidget(const YamagataLiveCameraApp());

    // Verify that region names are displayed
    expect(find.text('村山'), findsOneWidget);
    expect(find.text('最上'), findsOneWidget);
    expect(find.text('置賜'), findsOneWidget);
    expect(find.text('庄内'), findsOneWidget);
  });
}
