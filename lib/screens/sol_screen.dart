import 'package:flutter/material.dart';

import '../widgets/photo_grid.dart';
import 'empty_sol_screen.dart';

/// 02 · Explorar por Sol
class SolScreen extends StatelessWidget {
  const SolScreen({super.key});

  static const _cameras = [
    'Todas',
    'Risco dianteira',
    'Risco traseira',
    'Navegação',
    'Mastcam',
    'ChemCam',
    'MAHLI',
  ];

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Explorar por Sol')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Cada Sol é um dia marciano contado desde o pouso.'),
          const SizedBox(height: 16),
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton.outlined(
                        onPressed: () {},
                        icon: const Icon(Icons.remove),
                      ),
                      Text('Sol 1000', style: text.displaySmall),
                      IconButton.outlined(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  Slider(value: 1000, max: 5030, onChanged: (_) {}),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Sol 0 · pouso'), Text('Sol 5030 · hoje')],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final camera in _cameras)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(camera),
                      selected: camera == 'Todas',
                      onSelected: (_) {},
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text('870 fotos no Sol 1000', style: text.titleMedium),
          const SizedBox(height: 12),
          const PhotoGrid(count: 12),
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const EmptySolScreen()),
            ),
            child: const Text('Ver estado vazio'),
          ),
        ],
      ),
    );
  }
}
