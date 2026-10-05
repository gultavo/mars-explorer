/// Uma foto tirada pela Curiosity.
class MarsPhoto {
  const MarsPhoto({
    required this.id,
    required this.sol,
    required this.cameraCode,
    required this.cameraName,
    required this.earthDate,
    this.imageUrl,
    this.title = '',
    this.credit = 'NASA/JPL-Caltech',
  });

  final String id;
  final int sol;
  final String cameraCode;
  final String cameraName;
  final DateTime earthDate;

  /// `https_url` da API. Nulo enquanto os dados são fictícios.
  final String? imageUrl;
  final String title;
  final String credit;
}
