// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tmdb_app/main.dart';
import 'package:tmdb_app/features/popular_persons/popular_persons.dart';
import 'package:tmdb_app/features/popular_persons/widgets/error_message_widget.dart';
import 'package:tmdb_app/features/splash/splash.dart';

void main() {
  testWidgets('tmdb app test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.byType(MaterialApp), findsOneWidget);
    // await tester.pumpAndSettle();
    // await tester.pumpWidget(
    //     const MaterialApp(home:PopularPersonsScreen()));
    // await tester.pumpAndSettle();
    // expect(find.byType(Hero), findsOneWidget);
  //   await tester.pumpWidget(const PopularPersonsScreen());
  //   expect(find.byType(GridView), findsOneWidget);
  //   expect(find.byType(ErrorMessageWidget), findsNothing);
  //
  //   for (final element in find.byType(GridView).evaluate()) {
  //     await tester.tapAt(tester.getCenter(
  //         find.byWidget(element.widget)));
  //   }
  //   await tester.pump();
  //
   });
}
