import 'package:flutter_test/flutter_test.dart';

import 'package:mars_explorer/main.dart';

void main() {
  testWidgets('navega pelas cinco abas', (tester) async {
    await tester.pumpWidget(const MarsExplorerApp());
    expect(find.text('Mais recentes'), findsOneWidget);

    await tester.tap(find.text('Sol'));
    await tester.pumpAndSettle();
    expect(find.text('Explorar por Sol'), findsOneWidget);

    await tester.tap(find.text('Data'));
    await tester.pumpAndSettle();
    expect(find.text('Explorar por data'), findsOneWidget);

    await tester.tap(find.text('Favoritos'));
    await tester.pumpAndSettle();
    expect(find.text('3 fotos salvas · disponíveis offline'), findsOneWidget);

    await tester.tap(find.text('Sobre'));
    await tester.pumpAndSettle();
    expect(find.text('Curiosity'), findsOneWidget);
  });
}
