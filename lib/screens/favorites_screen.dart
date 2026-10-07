import 'package:flutter/material.dart';

import 'photo_detail_screen.dart';

/// 05 · Favoritos
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  static const _favorites = [
    ('Sol 5030', 'ChemCam · Remote Micro-Imager', '30/09/2026'),
    ('Sol 1004', 'Mastcam (esq.)', '03/06/2015'),
    ('Sol 1000', 'Câmera de risco dianteira (esq.)', '30/05/2015'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('3 fotos salvas · disponíveis offline'),
          const SizedBox(height: 16),
          for (final (sol, camera, date) in _favorites)
            Card(
              child: ListTile(
                leading: const Icon(Icons.image_outlined, size: 40),
                title: Text(sol),
                subtitle: Text('$camera\n$date'),
                isThreeLine: true,
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.close),
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PhotoDetailScreen()),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
