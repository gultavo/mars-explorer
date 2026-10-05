import 'package:flutter/material.dart';

import '../../state/shell_controller.dart';
import '../../widgets/mars_bottom_nav.dart';
import '../about/about_screen.dart';
import '../date/date_screen.dart';
import '../favorites/favorites_screen.dart';
import '../home/home_screen.dart';
import '../sol/sol_screen.dart';

/// Casca do app: mantém as 5 abas vivas e a barra de navegação inferior.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  final _controller = ShellController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShellScope(
      controller: _controller,
      child: ListenableBuilder(
        listenable: _controller,
        builder: (context, _) => Scaffold(
          extendBody: true,
          body: IndexedStack(
            index: _controller.tab.index,
            // Mesma ordem de [AppTab].
            children: const [
              HomeScreen(),
              SolScreen(),
              DateScreen(),
              FavoritesScreen(),
              AboutScreen(),
            ],
          ),
          bottomNavigationBar: MarsBottomNav(
            current: _controller.tab,
            onTap: _controller.goTo,
          ),
        ),
      ),
    );
  }
}
