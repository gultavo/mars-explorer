# mars-explorer

App Flutter para explorar as fotos do rover Curiosity em Marte.

## Telas

| # | Tela | Arquivo |
|---|------|---------|
| 01 | Início | `lib/screens/home/home_screen.dart` |
| 02 | Explorar por Sol | `lib/screens/sol/sol_screen.dart` |
| 03 | Explorar por data | `lib/screens/date/date_screen.dart` |
| 04 | Detalhe da foto | `lib/screens/photo_detail/photo_detail_screen.dart` |
| 05 | Favoritos | `lib/screens/favorites/favorites_screen.dart` |
| 06 | Sobre a Curiosity | `lib/screens/about/about_screen.dart` |
| 07 | Estado vazio (Sol sem fotos) | `lib/screens/sol/empty_sol_view.dart` |

Início, Sol e Data alimentam a mesma grade (`lib/widgets/photo_grid.dart`), que abre o Detalhe.
Favoritos abre direto o Detalhe. Sobre não depende da API.

## Estrutura

```
lib/
  main.dart            ponto de entrada e MaterialApp
  core/                tema (cores, tipografia) e formatadores
  models/              MarsPhoto, RoverCamera
  data/                dados fictícios (mock_data.dart)
  state/               aba ativa (ShellController) e favoritos (FavoritesStore)
  widgets/             componentes compartilhados
  screens/             uma pasta por tela + shell com a barra inferior
```

## Rodar

```bash
flutter run
```

Os dados ainda são fictícios; os pontos de integração estão marcados com `TODO`.
