import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../data/mock_data.dart';
import '../../state/shell_controller.dart';
import '../../widgets/photo_grid.dart';
import '../../widgets/screen_scaffold.dart';
import 'empty_sol_view.dart';

/// 02 · Explorar por Sol — seletor de Sol, filtro por câmera e grade de fotos.
/// Quando o Sol não tem fotos, mostra o estado vazio (07).
class SolScreen extends StatefulWidget {
  const SolScreen({super.key});

  @override
  State<SolScreen> createState() => _SolScreenState();
}

class _SolScreenState extends State<SolScreen> {
  static const _maxSol = MockData.currentSol;

  int _sol = 1000;
  String? _cameraCode;
  bool _loading = false;
  bool _empty = false;
  Timer? _timer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Outra tela pode pedir um Sol específico (ex.: "Sol sorteado").
    final requested = ShellScope.of(context).takeRequestedSol();
    if (requested != null) {
      _sol = requested;
      _empty = false;
      _simulateLoading();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // TODO: trocar pela busca real na API (25 fotos por página, rolagem infinita).
  void _simulateLoading() {
    _loading = true;
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 850), () {
      if (mounted) setState(() => _loading = false);
    });
  }

  void _setSol(int sol) => setState(() {
        _sol = sol.clamp(0, _maxSol);
        _empty = false;
        _simulateLoading();
      });

  void _setCamera(String? code) => setState(() {
        _cameraCode = code;
        _simulateLoading();
      });

  @override
  Widget build(BuildContext context) {
    if (_empty) {
      return ScreenBody(
        children: [
          const ScreenHeader(
            eyebrow: 'CURIOSITY · MSL',
            title: 'Explorar por Sol',
            subtitle: 'Cada Sol é um dia marciano contado desde o pouso.',
          ),
          EmptySolView(
            sol: _sol,
            onPrevious: () => _setSol(_sol - 1),
            onNext: () => _setSol(_sol + 1),
            onRandom: () => _setSol(Random().nextInt(_maxSol + 1)),
          ),
        ],
      );
    }

    final photos = MockData.photos(sol: _sol, cameraCode: _cameraCode);

    return ScreenBody(
      children: [
        const ScreenHeader(
          eyebrow: 'CURIOSITY · MSL',
          title: 'Explorar por Sol',
          subtitle: 'Cada Sol é um dia marciano contado desde o pouso.',
        ),
        _SolPicker(sol: _sol, max: _maxSol, onChanged: _setSol),
        _CameraChips(selected: _cameraCode, onSelected: _setCamera),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    _loading
                        ? 'Buscando fotos…'
                        : '${photos.length} fotos no Sol $_sol',
                    style: _loading
                        ? AppText.body
                        : const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                  ),
                ),
                Text(
                  _cameraCode ?? 'todas as câmeras',
                  style: AppText.mono.copyWith(fontSize: 10),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (_loading)
              const PhotoGridSkeleton()
            else
              PhotoGrid(photos: photos),
            const SizedBox(height: 12),
            // Atalho do wireframe para visualizar o estado vazio.
            Center(
              child: TextButton.icon(
                onPressed: () => setState(() => _empty = true),
                iconAlignment: IconAlignment.end,
                icon: const Icon(Icons.arrow_forward, size: 14),
                label: const Text('Simular Sol sem fotos'),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.textMuted,
                  textStyle: const TextStyle(fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SolPicker extends StatelessWidget {
  const _SolPicker({
    required this.sol,
    required this.max,
    required this.onChanged,
  });

  final int sol;
  final int max;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _StepButton(
                icon: Icons.remove,
                tooltip: 'Sol anterior',
                onPressed: () => onChanged(sol - 1),
              ),
              Column(
                children: [
                  Text(
                    'SOL',
                    style: AppText.mono.copyWith(
                      fontSize: 10,
                      letterSpacing: 2,
                    ),
                  ),
                  Text(
                    '$sol',
                    style: const TextStyle(
                      fontSize: 52,
                      height: 1,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1,
                    ),
                  ),
                ],
              ),
              _StepButton(
                icon: Icons.add,
                tooltip: 'Próximo Sol',
                onPressed: () => onChanged(sol + 1),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Semantics(
            label: 'Escolher Sol',
            child: Slider(
              value: sol.toDouble(),
              max: max.toDouble(),
              onChanged: (v) => onChanged(v.round()),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sol 0 · pouso',
                style: AppText.mono.copyWith(fontSize: 10),
              ),
              Text(
                'Sol $max · hoje',
                style: AppText.mono.copyWith(fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton.outlined(
      onPressed: onPressed,
      tooltip: tooltip,
      icon: Icon(icon, size: 20),
      style: IconButton.styleFrom(
        fixedSize: const Size(48, 48),
        foregroundColor: AppColors.text,
        side: const BorderSide(color: AppColors.borderStrong),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}

class _CameraChips extends StatelessWidget {
  const _CameraChips({required this.selected, required this.onSelected});

  final String? selected;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context) {
    final options = <(String?, String)>[
      (null, 'Todas'),
      for (final c in MockData.filterCameras) (c.code, c.label),
    ];

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemCount: options.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final (code, label) = options[i];
          final on = code == selected;
          return ChoiceChip(
            label: Text(label),
            selected: on,
            showCheckmark: false,
            onSelected: (_) => onSelected(code),
            backgroundColor: Colors.transparent,
            selectedColor: AppColors.accent,
            side: BorderSide(
              color: on ? AppColors.accent : AppColors.borderStrong,
            ),
            shape: const StadiumBorder(),
            labelStyle: TextStyle(
              fontSize: 13,
              fontWeight: on ? FontWeight.w700 : FontWeight.w400,
              color: on ? AppColors.onAccent : AppColors.text,
            ),
          );
        },
      ),
    );
  }
}
