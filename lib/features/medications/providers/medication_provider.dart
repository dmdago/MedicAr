import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/medication.dart';
import '../services/medication_service.dart';

// Service provider
final medicationServiceProvider = Provider<MedicationService>((ref) {
  return MedicationService();
});

// Provider para la query de búsqueda
final searchQueryProvider = StateProvider<String>((ref) => '');

// AsyncNotifier para manejar la búsqueda de medicamentos
class MedicationSearchNotifier extends AsyncNotifier<List<Medication>> {
  @override
  Future<List<Medication>> build() async {
    return [];
  }

  Future<void> search(String query) async {
    // Validar query (mínimo 3 caracteres sin contar espacios ni símbolos)
    if (!MedicationService.isValidQuery(query)) {
      state = const AsyncValue.data([]);
      return;
    }

    // Establecer estado de carga
    state = const AsyncValue.loading();

    try {
      final service = ref.read(medicationServiceProvider);
      final results = await service.searchMedications(query: query);
      state = AsyncValue.data(results);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  void clear() {
    state = const AsyncValue.data([]);
  }
}

// Provider del notifier
final medicationSearchProvider =
AsyncNotifierProvider<MedicationSearchNotifier, List<Medication>>(() {
  return MedicationSearchNotifier();
});