/// Câmera (instrumento) do rover Curiosity.
class RoverCamera {
  const RoverCamera({
    required this.code,
    required this.name,
    this.shortName,
    this.description = '',
  });

  /// Código usado pela API (ex.: `FHAZ_LEFT_B`).
  final String code;
  final String name;

  /// Rótulo curto para os chips de filtro.
  final String? shortName;
  final String description;

  String get label => shortName ?? name;
}
