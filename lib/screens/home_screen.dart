import 'package:flutter/material.dart';

import '../widgets/photo_grid.dart';

/// 01 · Início
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Mars Explorer')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Sol atual da missão · Curiosity'),
          Text('Sol 5030', style: text.displayMedium),
          const Text('última foto · 30/09/2026'),
          const SizedBox(height: 16),
          const SizedBox(
            height: 220,
            child: Card(
              margin: EdgeInsets.zero,
              child: Center(child: Text('Última imagem')),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: () {},
                  child: const Text('Sol aleatório'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('Por data'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text('Mais recentes', style: text.titleLarge),
          const SizedBox(height: 12),
          const PhotoGrid(),
        ],
      ),
    );
  }
}
