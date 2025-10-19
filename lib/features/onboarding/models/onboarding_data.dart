import 'package:flutter/material.dart';

class OnboardingData {
  final String title;
  final String description;
  final String imagePath; // ← Cambiado de icon a imagePath
  final Color color;
  final Color bgColor;

  OnboardingData({
    required this.title,
    required this.description,
    required this.imagePath, // ← Cambiado
    required this.color,
    required this.bgColor,
  });

  // Data estática
  static List<OnboardingData> get pages => [
    OnboardingData(
      title: 'Bienvenido',
      description: 'Descubre una nueva forma de gestionar tu salud',
      imagePath: 'assets/images/onb1.png', // ← Imagen 1
      color: Colors.blue,
      bgColor: Color(0xFF1479FF),
    ),
    OnboardingData(
      title: 'Fácil de Usar',
      description: 'Interfaz intuitiva diseñada pensando en ti',
      imagePath: 'assets/images/onb2.png', // ← Imagen 2
      color: Colors.green,
      bgColor: Color(0xFF1D3A62),
    ),
    OnboardingData(
      title: 'Comienza Ahora',
      description: '¡Estás listo para empezar esta aventura!',
      imagePath: 'assets/images/onb3.png', // ← Imagen 3
      color: Colors.orange,
      bgColor: Color(0xFFE8425E),
    ),
  ];
}