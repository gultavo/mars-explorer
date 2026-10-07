import 'package:flutter/material.dart';

import '../widgets/photo_grid.dart';

/// 03 · Explorar por data
class DateScreen extends StatelessWidget {
  const DateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Explorar por data')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Escolha um dia na Terra e veja o que a Curiosity fotografou.',
          ),
          const SizedBox(height: 16),
          Card(
            margin: EdgeInsets.zero,
            child: CalendarDatePicker(
              initialDate: DateTime(2015, 6, 3),
              firstDate: DateTime(2012, 8, 6),
              lastDate: DateTime(2026, 9, 30),
              onDateChanged: (_) {},
            ),
          ),
          const SizedBox(height: 16),
          Text('03/06/2015 · 8 fotos · Sol 1004', style: text.titleMedium),
          const SizedBox(height: 12),
          const PhotoGrid(count: 6),
        ],
      ),
    );
  }
}
