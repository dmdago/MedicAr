import 'package:flutter/material.dart';

class OnboardingData {
  final String title;
  final String description;
  final String imagePath;
  final Color color;
  final Color bgColor;

  OnboardingData({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.color,
    required this.bgColor,
  });

  // Data estática - Solo pantalla 1 visible
  static List<OnboardingData> get pages => [
    OnboardingData(
      title: 'Medicamentos',
      description: 'Consultá usos, dosis y presentaciones.',
      imagePath: 'assets/images/onb1.png',
      color: Color(0xFF1479FF),
      bgColor: Color(0xFF1479FF),
    ),
    // Pantallas 2 y 3 comentadas (ocultas pero no borradas)
    /*
    OnboardingData(
      title: 'Farmacias',
      description: 'No sabés que farmacia tenés cerca? Nosotros te ayudamos.',
      imagePath: 'assets/images/onb2.png',
      color: Color(0xFF1D3A62),
      bgColor: Color(0xFF1D3A62),
    ),
    OnboardingData(
      title: 'Centros de Salud',
      description: 'Encontrá el lugar mas cercano donde atenderte.',
      imagePath: 'assets/images/onb3.png',
      color: Color(0xFFE8425E),
      bgColor: Color(0xFFE8425E),
    ),
    */
  ];
}