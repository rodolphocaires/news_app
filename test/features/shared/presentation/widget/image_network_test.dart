import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:news_app/features/shared/shared.dart';

void main() {
  Future<void> pumpWidget({
    required WidgetTester tester,
    required String imageUrl,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) => ImageNetwork(
              imageUrl: imageUrl,
              defaultIconColor: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('should show image when imageUrl is not empty', (tester) async {
    await mockNetworkImagesFor(() => pumpWidget(
          tester: tester,
          imageUrl: 'https://example.com/some_image.jpg',
        ));
    await tester.pump();
    expect(find.byType(ImageNetwork), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('should show icon when image is empty', (tester) async {
    await pumpWidget(tester: tester, imageUrl: '');
    await tester.pump();
    expect(find.byType(ImageNetwork), findsOneWidget);
    expect(find.byType(Image), findsNothing);
    expect(find.byType(Icon), findsOneWidget);
  });
}
