import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatters.dart';
import '../../models/mars_photo.dart';
import '../../state/favorites_store.dart';
import '../../state/shell_controller.dart';
import '../../widgets/app_button.dart';
import '../../widgets/mars_planet.dart';
import '../../widgets/photo_image.dart';
import '../../widgets/screen_scaffold.dart';
import '../photo_detail/photo_detail_screen.dart';

/// 05 · Favoritos — fotos salvas no aparelho; abre direto o Detalhe.
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  void _remove(BuildContext context, MarsPhoto photo) {
    final store = FavoritesStore.instance;
    final index = store.remove(photo);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: const Text('Foto removida'),
          action: SnackBarAction(
            label: 'Desfazer',
            onPressed: () => store.insert(photo, index),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: FavoritesStore.instance,
      builder: (context, _) {
        final items = FavoritesStore.instance.items;
        final count = items.length;

        return ScreenBody(
          children: [
            ScreenHeader(
              eyebrow: 'SALVAS NO APARELHO',
              title: 'Favoritos',
              subtitle: count == 1
                  ? '1 foto salva · disponível offline'
                  : '$count fotos salvas · disponíveis offline',
            ),
            if (items.isEmpty)
              _EmptyFavorites(
                onExplore: () => ShellScope.of(context).goTo(AppTab.home),
              )
            else
              Column(
                children: [
                  for (final photo in items)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _FavoriteRow(
                        photo: photo,
                        onRemove: () => _remove(context, photo),
                      ),
                    ),
                ],
              ),
          ],
        );
      },
    );
  }
}

class _FavoriteRow extends StatelessWidget {
  const _FavoriteRow({required this.photo, required this.onRemove});

  final MarsPhoto photo;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        onTap: () => PhotoDetailScreen.open(context, photo),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: SizedBox.square(
                  dimension: 76,
                  child: PhotoImage(photo: photo),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sol ${photo.sol}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      photo.cameraName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSoft,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${photo.cameraCode} · ${formatDate(photo.earthDate)}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.mono.copyWith(fontSize: 10),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onRemove,
                tooltip: 'Remover dos favoritos',
                icon: const Icon(Icons.close, size: 18),
                color: AppColors.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyFavorites extends StatelessWidget {
  const _EmptyFavorites({required this.onExplore});

  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 60),
      child: Column(
        children: [
          const MarsPlanet(size: 96),
          const SizedBox(height: 22),
          const Text(
            'Nenhuma foto salva',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 14),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 260),
            child: const Text(
              'Toque no coração no detalhe de uma foto para guardá-la aqui.',
              textAlign: TextAlign.center,
              style: AppText.body,
            ),
          ),
          const SizedBox(height: 20),
          AppButton(
            label: 'Explorar fotos',
            trailingIcon: Icons.arrow_forward,
            filled: true,
            onPressed: onExplore,
          ),
        ],
      ),
    );
  }
}
