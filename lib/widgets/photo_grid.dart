import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../models/mars_photo.dart';
import '../screens/photo_detail/photo_detail_screen.dart';
import 'photo_image.dart';

const _gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 3,
  mainAxisSpacing: 8,
  crossAxisSpacing: 8,
);

/// Grade de 3 colunas compartilhada por Início, Sol e Data.
/// Tocar em uma foto abre o Detalhe.
class PhotoGrid extends StatelessWidget {
  const PhotoGrid({super.key, required this.photos});

  final List<MarsPhoto> photos;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: _gridDelegate,
      itemCount: photos.length,
      itemBuilder: (context, i) => _PhotoTile(photo: photos[i]),
    );
  }
}

/// Grade de carregamento (skeleton) no mesmo formato da [PhotoGrid].
class PhotoGridSkeleton extends StatelessWidget {
  const PhotoGridSkeleton({super.key, this.count = 9});

  final int count;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: _gridDelegate,
      itemCount: count,
      itemBuilder: (_, _) => DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.track,
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}

class _PhotoTile extends StatelessWidget {
  const _PhotoTile({required this.photo});

  final MarsPhoto photo;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Abrir foto ${photo.cameraCode}',
      child: Material(
        color: AppColors.placeholder,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: AppColors.border),
        ),
        child: InkWell(
          onTap: () => PhotoDetailScreen.open(context, photo),
          child: Stack(
            fit: StackFit.expand,
            children: [
              PhotoImage(photo: photo),
              Positioned(
                left: 6,
                right: 6,
                bottom: 6,
                child: Text(
                  photo.cameraCode,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.mono.copyWith(
                    fontSize: 8.5,
                    color: AppColors.textSoft,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
