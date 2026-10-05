import 'package:flutter/material.dart';

/// 07 · Estado vazio (Sol sem fotos)
class EmptySolScreen extends StatelessWidget {
  const EmptySolScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Explorar por Sol')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.public, size: 96),
            const SizedBox(height: 16),
            Text(
              'Nenhuma foto neste Sol',
              textAlign: TextAlign.center,
              style: text.headlineSmall,
            ),
            const SizedBox(height: 8),
            const Text(
              'Tente um Sol vizinho ou sorteie outro.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Sol anterior'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Sol seguinte'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            FilledButton(onPressed: () {}, child: const Text('Sol aleatório')),
          ],
        ),
      ),
    );
  }
}
