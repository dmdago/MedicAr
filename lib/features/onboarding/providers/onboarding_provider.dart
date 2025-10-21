import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider para el índice de página actual
final currentPageProvider = StateProvider<int>((ref) => 0);

// Provider para verificar si es la última página
final isLastPageProvider = Provider<bool>((ref) {
  final currentPage = ref.watch(currentPageProvider);
  return currentPage == 0; // Solo 1 página (índice 0)
});