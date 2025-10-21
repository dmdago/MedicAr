import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/medication.dart';

// Provider para la lista de medicamentos
final medicationsProvider = Provider<List<Medication>>((ref) {
  return Medication.getMockData();
});

// Provider para la query de búsqueda
final searchQueryProvider = StateProvider<String>((ref) => '');

// Provider para filtrar medicamentos
final filteredMedicationsProvider = Provider<List<Medication>>((ref) {
  final medications = ref.watch(medicationsProvider);
  final query = ref.watch(searchQueryProvider).toLowerCase();

  if (query.isEmpty) {
    return [];
  }

  return medications.where((medication) {
    return medication.name.toLowerCase().contains(query) ||
        medication.type.toLowerCase().contains(query);
  }).toList();
});