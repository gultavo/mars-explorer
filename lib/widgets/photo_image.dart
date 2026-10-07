import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../models/mars_photo.dart';

/// Imagem de uma foto; mostra um placeholder enquanto não há `imageUrl`.
class PhotoImage extends StatelessWidget {
  const PhotoImage({
    super.key,
    required this.photo,
    this.showIcon = false,
    this.iconSize = 34,
  });

  final MarsPhoto photo;
  final bool showIcon;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final placeholder = ColoredBox(
      color: AppColors.placeholder,
      child: showIcon
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.image_outlined,
                    size: iconSize,
                    color: const Color(0x59F1E7DC),
                  ),
                  const SizedBox(height: 6),
                  Text('https_url', style: AppText.mono.copyWith(fontSize: 10)),
                ],
              ),
            )
          : null,
    );

    final url = photo.imageUrl;
    if (url == null) return placeholder;
    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) => placeholder,
      loadingBuilder: (_, child, progress) =>
          progress == null ? child : placeholder,
    );
  }
}
