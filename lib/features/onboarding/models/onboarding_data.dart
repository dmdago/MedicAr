import 'package:flutter/material.dart';

class OnboardingData {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final Color bgColor; // ← Nuevo campo para el color del SVG de fondo

  OnboardingData({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.bgColor, // ← Agregado
  });

  // Data estática
  static List<OnboardingData> get pages => [
    OnboardingData(
      title: 'Bienvenido',
      description: 'Descubre una nueva forma de gestionar tu salud',
      icon: Icons.waving_hand,
      color: Colors.blue,
      bgColor: Color(0xFF1479FF), // ← Color de fondo para página 1
    ),
    OnboardingData(
      title: 'Fácil de Usar',
      description: 'Interfaz intuitiva diseñada pensando en ti',
      icon: Icons.touch_app,
      color: Colors.green,
      bgColor: Color(0xFF1D3A62), // ← Color de fondo para página 2
    ),
    OnboardingData(
      title: 'Comienza Ahora',
      description: '¡Estás listo para empezar esta aventura!',
      icon: Icons.rocket_launch,
      color: Colors.orange,
      bgColor: Color(0xFFE8425E), // ← Color de fondo para página 3
    ),
  ];
}