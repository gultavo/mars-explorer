import 'package:flutter/widgets.dart';

/// Abas da navegação principal, na ordem da barra inferior.
enum AppTab { home, sol, date, favorites, about }

/// Controla a aba ativa e permite que uma tela peça a troca de aba
/// (ex.: "Sol sorteado → Ver fotos" abre a aba Sol já naquele Sol).
class ShellController extends ChangeNotifier {
  AppTab _tab = AppTab.home;
  int? _requestedSol;

  AppTab get tab => _tab;

  void goTo(AppTab tab) {
    if (_tab == tab) return;
    _tab = tab;
    notifyListeners();
  }

  void openSol(int sol) {
    _requestedSol = sol;
    _tab = AppTab.sol;
    notifyListeners();
  }

  /// Lido (e limpo) pela tela de Sol ao ser notificada.
  int? takeRequestedSol() {
    final sol = _requestedSol;
    _requestedSol = null;
    return sol;
  }
}

class ShellScope extends InheritedNotifier<ShellController> {
  const ShellScope({
    super.key,
    required ShellController controller,
    required super.child,
  }) : super(notifier: controller);

  static ShellController of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ShellScope>()!.notifier!;
}
