import 'package:flutter/material.dart';

class OnboardingData {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  OnboardingData({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  // Data estática
  static List<OnboardingData> get pages => [
    OnboardingData(
      title: 'Bienvenido',
      description: 'Descubre una nueva forma de gestionar tu salud',
      icon: Icons.waving_hand,
      color: Colors.blue,
    ),
    OnboardingData(
      title: 'Fácil de Usar',
      description: 'Interfaz intuitiva diseñada pensando en ti',
      icon: Icons.touch_app,
      color: Colors.green,
    ),
    OnboardingData(
      title: 'Comienza Ahora',
      description: '¡Estás listo para empezar esta aventura!',
      icon: Icons.rocket_launch,
      color: Colors.orange,
    ),
  ];
}