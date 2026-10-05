import 'package:flutter/material.dart';

/// Esfera de Marte desenhada com gradiente (decoração recorrente do app).
class MarsPlanet extends StatelessWidget {
  const MarsPlanet({super.key, this.size = 40});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          center: Alignment(-0.36, -0.4),
          radius: 0.9,
          colors: [
            Color(0xFFF4A27C),
            Color(0xFFE2623A),
            Color(0xFF9C3317),
            Color(0xFF3B1409),
          ],
          stops: [0, 0.36, 0.68, 1],
        ),
        boxShadow: [BoxShadow(color: Color(0x59E2623A), blurRadius: 36)],
      ),
    );
  }
}

/// Planeta com anel de órbita tracejado, usado em "Sobre" e no estado vazio.
class OrbitingPlanet extends StatelessWidget {
  const OrbitingPlanet({super.key, this.size = 220, this.planetSize = 150});

  final double size;
  final double planetSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0x29F1E7DC)),
            ),
          ),
          MarsPlanet(size: planetSize),
        ],
      ),
    );
  }
}
