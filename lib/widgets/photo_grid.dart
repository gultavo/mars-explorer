import 'package:flutter/material.dart';

import '../screens/photo_detail_screen.dart';

/// Grade de fotos (por enquanto só espaços reservados).
/// Tocar em uma foto abre a tela de detalhe.
class PhotoGrid extends StatelessWidget {
  const PhotoGrid({super.key, this.count = 9});

  final int count;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        for (var i = 0; i < count; i++)
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PhotoDetailScreen()),
            ),
            child: const Card(
              margin: EdgeInsets.zero,
              child: Center(child: Icon(Icons.image_outlined)),
            ),
          ),
      ],
    );
  }
}
