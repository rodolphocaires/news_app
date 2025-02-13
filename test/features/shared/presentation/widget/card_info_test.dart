import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/features/shared/shared.dart';

void main() {
  Future<void> pumpWidget({
    required WidgetTester tester,
    required String author,
    required VoidCallback onTap,
    required String imageUrl,
    required String sourceName,
    required String titleNews,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) => CardInfo(
              author: author,
              onTap: onTap,
              imageUrl: imageUrl,
              sourceName: sourceName,
              titleNews: titleNews,
            ),
          ),
        ),
      ),
    );
  }

  testWidgets(
      'should render the widget correctly when widget is accessed by some page',
      (tester) async {
    await pumpWidget(
      tester: tester,
      author: 'author',
      onTap: () {},
      imageUrl: '',
      sourceName: 'sourceName',
      titleNews: 'titleNews',
    );
    await tester.pump();
    expect(find.byType(CardInfo), findsOneWidget);
    expect(find.byType(ImageNetwork), findsOneWidget);
    expect(find.text('sourceName - author'), findsOneWidget);
    expect(find.text('titleNews'), findsOneWidget);
  });

  group('source name and author', () {
    testWidgets('should show default message when source is not available',
        (tester) async {
      await pumpWidget(
        tester: tester,
        author: 'author',
        onTap: () {},
        imageUrl: '',
        sourceName: '',
        titleNews: 'titleNews',
      );
      await tester.pump();
      expect(find.text('Source not available - author'), findsOneWidget);
    });
    testWidgets('should not show author when it is empty', (tester) async {
      await pumpWidget(
        tester: tester,
        author: '',
        onTap: () {},
        imageUrl: '',
        sourceName: 'source name',
        titleNews: 'titleNews',
      );
      await tester.pump();
      expect(find.text('source name'), findsOneWidget);
    });
  });

  testWidgets('should call onTap when user taps on the widget', (tester) async {
    var tapped = false;
    await pumpWidget(
      tester: tester,
      author: '',
      onTap: () => tapped = !tapped,
      imageUrl: '',
      sourceName: 'source name',
      titleNews: 'titleNews',
    );
    await tester.pump();
    await tester.tap(find.byType(CardInfo));
    expect(tapped, isTrue);
  });
}
