import '../models/mars_photo.dart';
import '../models/rover_camera.dart';

/// Dados fictícios para montar as telas.
/// TODO: substituir por um serviço que consulte a API de imagens da NASA.
abstract final class MockData {
  /// Sol da última foto recebida.
  static const currentSol = 5030;
  static final lastPhotoDate = DateTime.utc(2026, 9, 30);
  static final landingDate = DateTime.utc(2012, 8, 6);

  /// Câmeras disponíveis como filtro na tela "Explorar por Sol".
  static const filterCameras = [
    RoverCamera(
      code: 'FHAZ_LEFT_B',
      name: 'Câmera de risco dianteira (esq.)',
      shortName: 'Risco dianteira (esq.)',
    ),
    RoverCamera(
      code: 'RHAZ_LEFT_B',
      name: 'Câmera de risco traseira (esq.)',
      shortName: 'Risco traseira (esq.)',
    ),
    RoverCamera(
      code: 'NAV_LEFT_B',
      name: 'Câmera de navegação (esq.)',
      shortName: 'Navegação (esq.)',
    ),
    RoverCamera(
      code: 'MAST_LEFT',
      name: 'Mastcam (esq.)',
    ),
    RoverCamera(
      code: 'CHEMCAM_RMI',
      name: 'ChemCam · Remote Micro-Imager',
      shortName: 'ChemCam',
    ),
    RoverCamera(
      code: 'MAHLI',
      name: 'Mars Hand Lens Imager',
      shortName: 'MAHLI',
    ),
  ];

  /// Câmeras descritas na tela "Sobre a Curiosity".
  static const aboutCameras = [
    RoverCamera(
      code: 'FHAZ',
      name: 'Câmeras de risco dianteiras',
      description:
          'Par estéreo na frente do rover, usado para detectar obstáculos no caminho.',
    ),
    RoverCamera(
      code: 'RHAZ',
      name: 'Câmeras de risco traseiras',
      description: 'A mesma função das dianteiras, voltada para trás do rover.',
    ),
    RoverCamera(
      code: 'NAVCAM',
      name: 'Câmeras de navegação',
      description: 'Par estéreo no mastro, usado para planejar os trajetos.',
    ),
    RoverCamera(
      code: 'MAST',
      name: 'Mastcam',
      description:
          'Câmeras coloridas no mastro para paisagens e alvos científicos.',
    ),
    RoverCamera(
      code: 'CHEMCAM_RMI',
      name: 'ChemCam · Remote Micro-Imager',
      description: 'Microimagens dos alvos que o ChemCam analisa com laser.',
    ),
    RoverCamera(
      code: 'MAHLI',
      name: 'Mars Hand Lens Imager',
      description:
          'Lente de aumento no braço robótico, para ver rochas e solo de perto.',
    ),
    RoverCamera(
      code: 'MARDI',
      name: 'Mars Descent Imager',
      description:
          'Filmou a descida e aponta para o solo logo abaixo do rover.',
    ),
  ];

  static MarsPhoto get latestPhoto => MarsPhoto(
        id: 'latest',
        sol: currentSol,
        cameraCode: 'CHEMCAM_RMI',
        cameraName: 'ChemCam · Remote Micro-Imager',
        earthDate: lastPhotoDate,
      );

  /// Data terrestre aproximada de um Sol (1 Sol ≈ 24h39min35s).
  static DateTime dateForSol(int sol) =>
      landingDate.add(Duration(seconds: (sol * 88775.244).round()));

  static int solForDate(DateTime date) =>
      (date.difference(landingDate).inSeconds / 88775.244).floor();

  /// Gera [count] fotos fictícias de um Sol, opcionalmente de uma só câmera.
  static List<MarsPhoto> photos({
    required int sol,
    String? cameraCode,
    int count = 12,
    DateTime? date,
  }) {
    final cameras = cameraCode == null
        ? filterCameras
        : filterCameras.where((c) => c.code == cameraCode).toList();
    if (cameras.isEmpty) return const [];
    return List.generate(count, (i) {
      final camera = cameras[i % cameras.length];
      return MarsPhoto(
        id: '$sol-${camera.code}-$i',
        sol: sol,
        cameraCode: camera.code,
        cameraName: camera.name,
        earthDate: date ?? dateForSol(sol),
      );
    });
  }
}
