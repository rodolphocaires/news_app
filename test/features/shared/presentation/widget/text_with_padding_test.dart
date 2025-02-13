import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/features/shared/shared.dart';

void main() {
  Future<void> pumpWidget({
    required WidgetTester tester,
    required String text,
    required String textPrefix,
    required double fontSize,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) => PaddingWithText(
              text: text,
              textPrefix: textPrefix,
              fontSize: fontSize,
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('should render the widget correctly when text is not empty',
      (tester) async {
    await pumpWidget(
      tester: tester,
      text: 'text',
      textPrefix: 'textPrefix',
      fontSize: 12.0,
    );
    await tester.pump();
    expect(find.byType(PaddingWithText), findsOneWidget);
    expect(find.text('textPrefix text'), findsOneWidget);
  });

  testWidgets('should render just the text when textPrefix is empty',
      (tester) async {
    await pumpWidget(
      tester: tester,
      text: 'text',
      textPrefix: '',
      fontSize: 12.0,
    );
    await tester.pump();
    expect(find.byType(PaddingWithText), findsOneWidget);
    expect(find.text('text'), findsOneWidget);
  });

  testWidgets('should not render widget when text is empty', (tester) async {
    await pumpWidget(
      tester: tester,
      text: '',
      textPrefix: 'textPrefix',
      fontSize: 12.0,
    );
    await tester.pump();
    expect(find.byType(PaddingWithText), findsOneWidget);
    expect(find.text('textPrefix'), findsNothing);
  });
}
