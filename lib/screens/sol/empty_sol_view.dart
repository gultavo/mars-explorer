import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/app_button.dart';
import '../../widgets/mars_planet.dart';

/// 07 · Estado vazio — Sol sem fotos, com atalhos para tentar outro Sol.
class EmptySolView extends StatelessWidget {
  const EmptySolView({
    super.key,
    required this.sol,
    required this.onPrevious,
    required this.onNext,
    required this.onRandom,
  });

  final int sol;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onRandom;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      child: Column(
        children: [
          const OrbitingPlanet(size: 240, planetSize: 110),
          const SizedBox(height: 16),
          Text(
            'SOL $sol · 0 FOTOS',
            style: AppText.eyebrow.copyWith(color: AppColors.accentLight),
          ),
          const SizedBox(height: 16),
          const Text(
            'Nenhuma foto neste Sol',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              height: 1.1,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 290),
            child: Text(
              'A API não informa de antemão quais Sols têm fotos. '
              'Tente um Sol vizinho ou sorteie outro.',
              textAlign: TextAlign.center,
              style: AppText.body.copyWith(height: 1.5),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  label: 'Sol anterior',
                  icon: Icons.chevron_left,
                  onPressed: onPrevious,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: AppButton(
                  label: 'Sol seguinte',
                  trailingIcon: Icons.chevron_right,
                  onPressed: onNext,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: AppButton(
              label: 'Sol aleatório',
              icon: Icons.casino_outlined,
              filled: true,
              onPressed: onRandom,
            ),
          ),
        ],
      ),
    );
  }
}
