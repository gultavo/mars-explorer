import 'package:flutter/material.dart';

/// 04 · Detalhe da foto
class PhotoDetailScreen extends StatelessWidget {
  const PhotoDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Detalhe da foto')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(
            child: Card(
              margin: EdgeInsets.all(16),
              child: Center(child: Icon(Icons.image_outlined, size: 48)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('SOL 1000 · CURIOSITY'),
                Text(
                  'Câmera de risco dianteira (esq.)',
                  style: text.headlineSmall,
                ),
                const SizedBox(height: 16),
                const Row(
                  children: [
                    Expanded(child: _Field('Sol', '1000')),
                    Expanded(child: _Field('Data na Terra', '30/05/2015')),
                  ],
                ),
                const SizedBox(height: 12),
                const Row(
                  children: [
                    Expanded(child: _Field('Câmera', 'FHAZ_LEFT_B')),
                    Expanded(child: _Field('Crédito', 'NASA/JPL-Caltech')),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border),
                        label: const Text('Favoritar'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.share),
                        label: const Text('Compartilhar'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelSmall),
        Text(value),
      ],
    );
  }
}
