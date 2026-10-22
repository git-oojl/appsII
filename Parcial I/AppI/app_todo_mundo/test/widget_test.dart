import 'package:flutter_test/flutter_test.dart';

import 'package:app_todo_mundo/main.dart';

void main() {
  testWidgets('shows Hello World', (WidgetTester tester) async {
    await tester.pumpWidget(const MainApp());

    expect(find.text('Hello World!'), findsOneWidget);
  });
}
