import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mars_explorer/main.dart';

void main() {
  testWidgets('navega pelas cinco abas', (tester) async {
    await tester.pumpWidget(const MarsExplorerApp());
    expect(find.text('MARS EXPLORER'), findsOneWidget);

    await tester.tap(find.text('Sol'));
    await tester.pumpAndSettle();
    expect(find.text('Explorar por Sol'), findsOneWidget);

    await tester.tap(find.text('Data'));
    await tester.pumpAndSettle();
    expect(find.text('Explorar por data'), findsOneWidget);

    await tester.tap(find.text('Favoritos').last);
    await tester.pumpAndSettle();
    expect(find.text('Nenhuma foto salva'), findsOneWidget);

    await tester.tap(find.text('Sobre'));
    await tester.pumpAndSettle();
    expect(find.text('Curiosity'), findsOneWidget);
  });

  testWidgets('abre o detalhe e favorita uma foto', (tester) async {
    await tester.pumpWidget(const MarsExplorerApp());

    await tester.tap(find.text('Última imagem'));
    await tester.pumpAndSettle();
    expect(find.text('Favoritar'), findsOneWidget);

    await tester.tap(find.text('Favoritar'));
    await tester.pump();
    expect(find.text('Salva'), findsOneWidget);

    await tester.tap(find.byTooltip('Voltar'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pumpAndSettle();
    expect(find.text('1 foto salva · disponível offline'), findsOneWidget);
  });
}
