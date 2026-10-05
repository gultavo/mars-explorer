# mars-explorer

App Flutter para explorar as fotos do rover Curiosity em Marte.

> **Status:** por enquanto só a estrutura das telas, com conteúdo fixo e sem funcionalidades (sem API, sem navegação entre telas além da barra inferior).

## Requisitos

Ferramentas necessárias para rodar o projeto:

| Ferramenta | Versão | Observação |
|------------|--------|------------|
| Flutter SDK | 3.44.4 (canal `stable`) | Versão com a qual o projeto foi desenvolvido |
| Dart SDK | 3.12.2 ou superior | Já vem com o Flutter; exigido em `pubspec.yaml` (`sdk: ^3.12.2`) |
| Android Studio / SDK Android | recente | Para rodar em emulador ou dispositivo Android |
| Xcode | recente | Só no macOS, para rodar no iOS |
| Chrome | recente | Para rodar na web |

Confira sua instalação com:

```bash
flutter --version
flutter doctor
```

## Pacotes

Declarados em `pubspec.yaml` (versões resolvidas em `pubspec.lock`).

### Dependências

| Pacote | Versão exigida | Versão instalada | Uso |
|--------|----------------|------------------|-----|
| `flutter` | SDK | SDK | Framework |
| `cupertino_icons` | `^1.0.8` | 1.0.9 | Ícones estilo iOS |

### Dependências de desenvolvimento

| Pacote | Versão exigida | Versão instalada | Uso |
|--------|----------------|------------------|-----|
| `flutter_test` | SDK | SDK | Testes de widget |
| `flutter_lints` | `^6.0.0` | 6.0.0 | Regras de lint (via `analysis_options.yaml`) |

## Como rodar

```bash
git clone https://github.com/gultavo/mars-explorer.git
cd mars-explorer
flutter pub get
flutter run
```

Para escolher a plataforma:

```bash
flutter devices          # lista dispositivos disponíveis
flutter run -d chrome    # web
flutter run -d <id>      # emulador ou dispositivo específico
```

## Testes e análise

```bash
flutter analyze
flutter test
```

## Telas

| # | Tela | Arquivo |
|---|------|---------|
| 01 | Início | `lib/screens/home_screen.dart` |
| 02 | Explorar por Sol | `lib/screens/sol_screen.dart` |
| 03 | Explorar por data | `lib/screens/date_screen.dart` |
| 04 | Detalhe da foto | `lib/screens/photo_detail_screen.dart` |
| 05 | Favoritos | `lib/screens/favorites_screen.dart` |
| 06 | Sobre a Curiosity | `lib/screens/about_screen.dart` |
| 07 | Estado vazio (Sol sem fotos) | `lib/screens/empty_sol_screen.dart` |

A barra inferior com as cinco abas fica em `lib/main.dart`.

## Estrutura do projeto

```
lib/
├── main.dart              # Ponto de entrada e barra inferior com as abas
├── screens/               # Telas do app
└── widgets/
    └── photo_grid.dart    # Grade de fotos reutilizável
test/                      # Testes
android/ ios/ web/         # Plataformas suportadas
```
