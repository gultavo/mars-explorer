import 'package:flutter/material.dart';

/// 06 · Sobre a Curiosity
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static const _facts = [
    ('Lançamento', '26/11/2011'),
    ('Pouso', '06/08/2012 · Sol 0'),
    ('Local', 'Cratera Gale'),
    ('Última foto recebida', 'Sol 5030'),
  ];

  static const _cameras = [
    ('Câmeras de risco dianteiras', 'Par estéreo na frente do rover, usado para detectar obstáculos no caminho.'),
    ('Câmeras de risco traseiras', 'A mesma função das dianteiras, voltada para trás do rover.'),
    ('Câmeras de navegação', 'Par estéreo no mastro, usado para planejar os trajetos.'),
    ('Mastcam', 'Câmeras coloridas no mastro para paisagens e alvos científicos.'),
    ('ChemCam · Remote Micro-Imager', 'Microimagens dos alvos que o ChemCam analisa com laser.'),
    ('Mars Hand Lens Imager', 'Lente de aumento no braço robótico, para ver rochas e solo de perto.'),
    ('Mars Descent Imager', 'Filmou a descida e aponta para o solo logo abaixo do rover.'),
  ];

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Sobre a Curiosity')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Icon(Icons.public, size: 120),
          const SizedBox(height: 8),
          Text('Curiosity', textAlign: TextAlign.center, style: text.displaySmall),
          const Text(
            'Rover da NASA que explora a cratera Gale.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Card(
            margin: EdgeInsets.zero,
            child: Column(
              children: [
                for (final (label, value) in _facts)
                  ListTile(title: Text(label), trailing: Text(value)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text('Câmeras', style: text.titleLarge),
          for (final (name, description) in _cameras)
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(name),
              subtitle: Text(description),
            ),
        ],
      ),
    );
  }
}
