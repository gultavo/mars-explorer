import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatters.dart';
import '../../models/mars_photo.dart';
import '../../state/favorites_store.dart';
import '../../widgets/app_button.dart';
import '../../widgets/photo_image.dart';

/// 04 · Detalhe da foto — imagem com zoom, metadados, favoritar e compartilhar.
class PhotoDetailScreen extends StatefulWidget {
  const PhotoDetailScreen({super.key, required this.photo});

  final MarsPhoto photo;

  static Future<void> open(BuildContext context, MarsPhoto photo) {
    return Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => PhotoDetailScreen(photo: photo)),
    );
  }

  @override
  State<PhotoDetailScreen> createState() => _PhotoDetailScreenState();
}

class _PhotoDetailScreenState extends State<PhotoDetailScreen> {
  static const _zoomLevels = [1.0, 1.5, 2.0, 3.0];

  final _transform = TransformationController();
  Size _viewport = Size.zero;

  @override
  void dispose() {
    _transform.dispose();
    super.dispose();
  }

  double get _scale => _transform.value.getMaxScaleOnAxis();

  /// Aplica o zoom mantendo o centro da imagem no centro da área visível.
  void _setScale(double scale) {
    _transform.value = Matrix4.identity()
      ..setEntry(0, 0, scale)
      ..setEntry(1, 1, scale)
      ..setEntry(0, 3, -(scale - 1) * _viewport.width / 2)
      ..setEntry(1, 3, -(scale - 1) * _viewport.height / 2);
  }

  void _zoomIn() => _setScale(
        _zoomLevels.firstWhere((z) => z > _scale + 0.01, orElse: () => 3),
      );

  void _zoomOut() => _setScale(
        _zoomLevels.lastWhere((z) => z < _scale - 0.01, orElse: () => 1),
      );

  void _cycleZoom() => _scale >= 3 - 0.01 ? _setScale(1) : _zoomIn();

  void _toast(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleFavorite() {
    final store = FavoritesStore.instance;
    final wasFavorite = store.contains(widget.photo);
    store.toggle(widget.photo);
    _toast(wasFavorite ? 'Removida dos favoritos' : 'Salva para ver offline');
  }

  // TODO: usar a folha de compartilhamento nativa quando houver URL real.
  Future<void> _share() async {
    final url = widget.photo.imageUrl;
    if (url == null) {
      _toast('Esta foto ainda não tem link');
      return;
    }
    await Clipboard.setData(ClipboardData(text: url));
    if (mounted) _toast('Link da imagem copiado');
  }

  @override
  Widget build(BuildContext context) {
    final photo = widget.photo;

    return Scaffold(
      backgroundColor: const Color(0xFF110C0A),
      body: Column(
        children: [
          Expanded(child: _buildImageArea(photo)),
          _buildInfoPanel(photo),
        ],
      ),
    );
  }

  Widget _buildImageArea(MarsPhoto photo) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _viewport = constraints.biggest;
        return Stack(
          fit: StackFit.expand,
          children: [
            GestureDetector(
              onDoubleTap: _cycleZoom,
              child: InteractiveViewer(
                transformationController: _transform,
                minScale: 1,
                maxScale: 3,
                child: PhotoImage(photo: photo, showIcon: true, iconSize: 40),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _OverlayButton(
                          icon: Icons.chevron_left,
                          tooltip: 'Voltar',
                          circular: true,
                          onPressed: () => Navigator.of(context).maybePop(),
                        ),
                        ListenableBuilder(
                          listenable: _transform,
                          builder: (_, _) => _ZoomPill(scale: _scale),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _OverlayButton(
                            icon: Icons.add,
                            tooltip: 'Aproximar',
                            onPressed: _zoomIn,
                          ),
                          const SizedBox(height: 8),
                          _OverlayButton(
                            icon: Icons.remove,
                            tooltip: 'Afastar',
                            onPressed: _zoomOut,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInfoPanel(MarsPhoto photo) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        top: false,
        minimum: const EdgeInsets.fromLTRB(20, 14, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.handle,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'SOL ${photo.sol} · CURIOSITY',
              style: AppText.mono.copyWith(
                fontSize: 10,
                letterSpacing: 2,
                color: AppColors.accentLight,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              photo.cameraName,
              style: const TextStyle(
                fontSize: 24,
                height: 1.15,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (photo.title.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(photo.title, style: AppText.body.copyWith(fontSize: 13)),
            ],
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(child: _Field(label: 'SOL', value: '${photo.sol}')),
                Expanded(
                  child: _Field(
                    label: 'DATA NA TERRA',
                    value: formatDateTime(photo.earthDate),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: _Field(label: 'CÂMERA', value: photo.cameraCode),
                ),
                Expanded(child: _Field(label: 'CRÉDITO', value: photo.credit)),
              ],
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: ListenableBuilder(
                    listenable: FavoritesStore.instance,
                    builder: (context, _) {
                      final saved = FavoritesStore.instance.contains(photo);
                      return AppButton(
                        label: saved ? 'Salva' : 'Favoritar',
                        icon: saved ? Icons.favorite : Icons.favorite_border,
                        filled: !saved,
                        onPressed: _toggleFavorite,
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: AppButton(
                    label: 'Compartilhar',
                    icon: Icons.ios_share,
                    onPressed: _share,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppText.mono.copyWith(fontSize: 10, letterSpacing: 1.4),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class _ZoomPill extends StatelessWidget {
  const _ZoomPill({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final rounded = (scale * 10).round() / 10;
    final text = rounded == rounded.roundToDouble()
        ? '${rounded.round()}'
        : rounded.toStringAsFixed(1).replaceAll('.', ',');
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
        'zoom $text×',
        style: AppText.mono.copyWith(color: AppColors.text),
      ),
    );
  }
}

class _OverlayButton extends StatelessWidget {
  const _OverlayButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.circular = false,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  final bool circular;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      tooltip: tooltip,
      icon: Icon(icon, size: 20),
      style: IconButton.styleFrom(
        fixedSize: const Size(44, 44),
        backgroundColor: AppColors.overlay,
        foregroundColor: AppColors.text,
        side: const BorderSide(color: AppColors.borderStrong),
        shape: circular
            ? const CircleBorder()
            : RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
