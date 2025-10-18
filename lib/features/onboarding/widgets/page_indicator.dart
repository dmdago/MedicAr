import 'package:flutter/material.dart';
import '../models/onboarding_data.dart';

class PageIndicator extends StatelessWidget {
  final int currentPage;
  final List<OnboardingData> pages;

  const PageIndicator({
    Key? key,
    required this.currentPage,
    required this.pages,
  }) : super(key: key);

  // Función para aclarar un color en un porcentaje
  Color _lightenColor(Color color, double percentage) {
    final hsl = HSLColor.fromColor(color);
    final lightness = (hsl.lightness + percentage).clamp(0.0, 1.0);
    return hsl.withLightness(lightness).toColor();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pages.length,
            (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: currentPage == index ? 24 : 8,
          decoration: BoxDecoration(
            color: currentPage == index
                ? _lightenColor(pages[index].bgColor, 0.2) // 10% más claro
                : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}