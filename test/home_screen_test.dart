import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ptn_assignment/features/pages/home/screen/home_screen.dart';

void main() {
  testWidgets('HomeScreen displays logo and category list', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );

    expect(find.byType(Image), findsOneWidget);

    expect(find.text('Catalog'), findsOneWidget);

    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets('HomeScreen updates searchQueryProvider', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField), 'Flutter');

    await tester.pump();

    expect(find.text('Flutter'), findsOneWidget);
  });
}
