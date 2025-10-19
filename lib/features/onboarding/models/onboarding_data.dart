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
      title: 'Medicamentos',
      description: 'Consultá usos, dosis y presentaciones.',
      imagePath: 'assets/images/onb1.png', // ← Imagen 1
      color: Color(0xFF1479FF),
      bgColor: Color(0xFF1479FF),
    ),
    OnboardingData(
      title: 'Farmacias',
      description: 'No sabés que farmacia tenés cerca? Nosotros te ayudamos.',
      imagePath: 'assets/images/onb2.png', // ← Imagen 2
      color: Color(0xFF1D3A62),
      bgColor: Color(0xFF1D3A62),
    ),
    OnboardingData(
      title: 'Centros de Salud',
      description: 'Encontrá el lugar mas cercano donde atenderte.',
      imagePath: 'assets/images/onb3.png', // ← Imagen 3
      color: Color(0xFFE8425E),
      bgColor: Color(0xFFE8425E),
    ),
  ];
}