import 'dart:math';

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatters.dart';
import '../../data/mock_data.dart';
import '../../models/mars_photo.dart';
import '../../state/shell_controller.dart';
import '../../widgets/app_button.dart';
import '../../widgets/mars_planet.dart';
import '../../widgets/photo_grid.dart';
import '../../widgets/photo_image.dart';
import '../../widgets/screen_scaffold.dart';
import '../photo_detail/photo_detail_screen.dart';

/// 01 · Início — Sol atual, última imagem, atalhos e fotos mais recentes.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _random = Random();
  final _recent = MockData.photos(sol: MockData.currentSol, count: 9);
  int? _rolledSol;

  @override
  Widget build(BuildContext context) {
    final shell = ShellScope.of(context);
    final rolled = _rolledSol;

    return ScreenBody(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('MARS EXPLORER', style: AppText.eyebrow),
            MarsPlanet(),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                CircleAvatar(radius: 4, backgroundColor: AppColors.accent),
                SizedBox(width: 8),
                Text(
                  'Sol atual da missão · Curiosity',
                  style: TextStyle(fontSize: 13, color: AppColors.textMuted),
                ),
              ],
            ),
            const SizedBox(height: 6),
            const FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Sol ${MockData.currentSol}',
                style: TextStyle(
                  fontSize: 72,
                  height: 0.95,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1.4,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'última foto · ${formatDate(MockData.lastPhotoDate)}',
              style: AppText.mono.copyWith(fontSize: 12),
            ),
          ],
        ),
        _LatestPhotoCard(photo: MockData.latestPhoto),
        Row(
          children: [
            Expanded(
              child: AppButton(
                label: 'Sol aleatório',
                icon: Icons.casino_outlined,
                filled: true,
                onPressed: () => setState(
                  () => _rolledSol = _random.nextInt(MockData.currentSol + 1),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: AppButton(
                label: 'Por data',
                icon: Icons.calendar_today_outlined,
                onPressed: () => shell.goTo(AppTab.date),
              ),
            ),
          ],
        ),
        if (rolled != null)
          _RolledSolCard(sol: rolled, onTap: () => shell.openSol(rolled)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Mais recentes', style: AppText.sectionTitle),
            const SizedBox(height: 12),
            PhotoGrid(photos: _recent),
          ],
        ),
      ],
    );
  }
}

class _LatestPhotoCard extends StatelessWidget {
  const _LatestPhotoCard({required this.photo});

  final MarsPhoto photo;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Abrir a última imagem',
      child: Material(
        color: AppColors.placeholder,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: AppColors.border),
        ),
        child: InkWell(
          onTap: () => PhotoDetailScreen.open(context, photo),
          child: SizedBox(
            height: 250,
            child: Stack(
              fit: StackFit.expand,
              children: [
                PhotoImage(photo: photo, showIcon: true),
                const Positioned(
                  left: 14,
                  top: 14,
                  child: _Pill(label: 'Última imagem'),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0x000C0908), Color(0xEB0C0908)],
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                photo.cameraName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${photo.cameraCode} · Sol ${photo.sol}',
                                style: AppText.mono,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        const CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.accent,
                          foregroundColor: AppColors.onAccent,
                          child: Icon(Icons.arrow_forward, size: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.overlay,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.borderStrong),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
      ),
    );
  }
}

/// Cartão que aparece depois de sortear um Sol; leva à aba Sol.
class _RolledSolCard extends StatelessWidget {
  const _RolledSolCard({required this.sol, required this.onTap});

  final int sol;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Color(0x8CE2623A)),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SOL SORTEADO',
                      style: AppText.mono.copyWith(
                        fontSize: 10,
                        letterSpacing: 1.8,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Sol $sol',
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                'Ver fotos',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.accentLight,
                ),
              ),
              const SizedBox(width: 6),
              const Icon(
                Icons.arrow_forward,
                size: 16,
                color: AppColors.accentLight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
