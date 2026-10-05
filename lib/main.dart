import 'package:flutter/material.dart';

import 'screens/about_screen.dart';
import 'screens/date_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/home_screen.dart';
import 'screens/sol_screen.dart';

void main() => runApp(const MarsExplorerApp());

class MarsExplorerApp extends StatelessWidget {
  const MarsExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mars Explorer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE2623A),
          brightness: Brightness.dark,
        ),
      ),
      home: const MainScreen(),
    );
  }
}

/// Barra inferior com as cinco abas do app.
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 0;

  static const _screens = [
    HomeScreen(),
    SolScreen(),
    DateScreen(),
    FavoritesScreen(),
    AboutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Início'),
          NavigationDestination(icon: Icon(Icons.wb_sunny_outlined), label: 'Sol'),
          NavigationDestination(icon: Icon(Icons.calendar_today_outlined), label: 'Data'),
          NavigationDestination(icon: Icon(Icons.favorite_border), label: 'Favoritos'),
          NavigationDestination(icon: Icon(Icons.info_outline), label: 'Sobre'),
        ],
      ),
    );
  }
}
