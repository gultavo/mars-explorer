import 'package:flutter/foundation.dart';

import '../models/mars_photo.dart';

/// Fotos favoritas, por enquanto só em memória.
/// TODO: persistir localmente (o wireframe prevê uso offline).
class FavoritesStore extends ChangeNotifier {
  FavoritesStore._();
  static final instance = FavoritesStore._();

  final List<MarsPhoto> _items = [];

  List<MarsPhoto> get items => List.unmodifiable(_items);

  bool contains(MarsPhoto photo) => _items.any((p) => p.id == photo.id);

  void toggle(MarsPhoto photo) =>
      contains(photo) ? remove(photo) : insert(photo);

  void insert(MarsPhoto photo, [int index = 0]) {
    if (contains(photo)) return;
    _items.insert(index.clamp(0, _items.length), photo);
    notifyListeners();
  }

  /// Remove e devolve a posição que a foto ocupava (para o "Desfazer").
  int remove(MarsPhoto photo) {
    final index = _items.indexWhere((p) => p.id == photo.id);
    if (index >= 0) {
      _items.removeAt(index);
      notifyListeners();
    }
    return index;
  }
}
