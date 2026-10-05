import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../data/mock_data.dart';
import '../../models/rover_camera.dart';
import '../../widgets/mars_planet.dart';
import '../../widgets/screen_scaffold.dart';

/// 06 · Sobre a Curiosity — conteúdo local, não depende da API.
class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  // Só uma câmera fica aberta por vez.
  String? _openCode = MockData.aboutCameras.first.code;

  @override
  Widget build(BuildContext context) {
    return ScreenBody(
      children: [
        Column(
          children: [
            const OrbitingPlanet(),
            const SizedBox(height: 14),
            const Text('MISSION · MSL', style: AppText.eyebrow),
            const SizedBox(height: 14),
            const Text(
              'Curiosity',
              style: TextStyle(
                fontSize: 48,
                height: 1,
                fontWeight: FontWeight.w800,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 14),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300),
              child: const Text(
                'Rover da NASA que explora a cratera Gale em Marte.',
                textAlign: TextAlign.center,
                style: AppText.body,
              ),
            ),
          ],
        ),
        const SurfaceCard(
          radius: 22,
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
          child: Column(
            children: [
              _FactRow(label: 'Lançamento', value: '26/11/2011'),
              _FactRow(label: 'Pouso', value: '06/08/2012 · Sol 0'),
              _FactRow(label: 'Local', value: 'Cratera Gale'),
              _FactRow(
                label: 'Última foto recebida',
                value: 'Sol ${MockData.currentSol}',
                last: true,
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Câmeras', style: AppText.sectionTitle),
            for (final camera in MockData.aboutCameras)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: _CameraTile(
                  camera: camera,
                  open: camera.code == _openCode,
                  onToggle: () => setState(
                    () => _openCode =
                        camera.code == _openCode ? null : camera.code,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _FactRow extends StatelessWidget {
  const _FactRow({required this.label, required this.value, this.last = false});

  final String label;
  final String value;
  final bool last;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 48),
      decoration: BoxDecoration(
        border: last
            ? null
            : const Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Expanded(child: Text(label, style: AppText.body)),
          Text(value, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}

class _CameraTile extends StatelessWidget {
  const _CameraTile({
    required this.camera,
    required this.open,
    required this.onToggle,
  });

  final RoverCamera camera;
  final bool open;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        onTap: onToggle,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          camera.name,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          camera.code,
                          style: AppText.mono.copyWith(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: open ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: const Icon(
                      Icons.expand_more,
                      color: AppColors.accentLight,
                    ),
                  ),
                ],
              ),
              if (open) ...[
                const SizedBox(height: 10),
                Text(
                  camera.description,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: AppColors.textSoft,
                  ),
                ),
                const SizedBox(height: 6),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
