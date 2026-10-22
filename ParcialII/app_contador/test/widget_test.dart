import 'package:contador_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('muestra el contador e incrementa el valor', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MainApp());

    expect(find.text('Pantalla del contador'), findsOneWidget);
    expect(find.byKey(const ValueKey('valor-contador')), findsOneWidget);
    expect(find.text('0'), findsOneWidget);
    expect(find.text('Clicks'), findsOneWidget);

    await tester.tap(find.byTooltip('Incrementar'));
    await tester.pump();

    expect(find.text('1'), findsOneWidget);
    expect(find.text('Click'), findsOneWidget);
  });

  testWidgets('decrementa hasta cero y permite reiniciar', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MainApp());

    await tester.tap(find.byTooltip('Incrementar'));
    await tester.tap(find.byTooltip('Incrementar'));
    await tester.pump();
    expect(find.text('2'), findsOneWidget);

    await tester.tap(find.byTooltip('Decrementar'));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.byTooltip('Reiniciar contador'));
    await tester.pump();
    expect(find.text('0'), findsOneWidget);
  });
}
