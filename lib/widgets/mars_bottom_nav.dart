import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../state/shell_controller.dart';

/// Barra de navegação flutuante com as 5 abas.
class MarsBottomNav extends StatelessWidget {
  const MarsBottomNav({super.key, required this.current, required this.onTap});

  final AppTab current;
  final ValueChanged<AppTab> onTap;

  static const _items = {
    AppTab.home: (Icons.home_outlined, 'Início'),
    AppTab.sol: (Icons.wb_sunny_outlined, 'Sol'),
    AppTab.date: (Icons.calendar_today_outlined, 'Data'),
    AppTab.favorites: (Icons.favorite_border, 'Favoritos'),
    AppTab.about: (Icons.info_outline, 'Sobre'),
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      minimum: const EdgeInsets.fromLTRB(12, 0, 12, 14),
      child: Container(
        height: 68,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: const Color(0xF216110F),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.border),
          boxShadow: const [
            BoxShadow(
              color: Color(0x73000000),
              blurRadius: 32,
              offset: Offset(0, 12),
            ),
          ],
        ),
        child: Row(
          children: [
            for (final entry in _items.entries)
              Expanded(
                child: _NavTab(
                  icon: entry.value.$1,
                  label: entry.value.$2,
                  selected: entry.key == current,
                  onTap: () => onTap(entry.key),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _NavTab extends StatelessWidget {
  const _NavTab({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      selected: selected,
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          height: 56,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 22,
                color: selected ? AppColors.accent : AppColors.textMuted,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: selected ? AppColors.text : AppColors.textMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
