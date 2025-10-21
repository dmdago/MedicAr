import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/medication.dart';
import '../widgets/medication_card.dart';
import '../providers/medication_provider.dart';
import '../services/medication_service.dart';

class MedicationsScreen extends ConsumerStatefulWidget {
  const MedicationsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MedicationsScreen> createState() => _MedicationsScreenState();
}

class _MedicationsScreenState extends ConsumerState<MedicationsScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    print('🔤 Search changed: "$value"');
    ref.read(searchQueryProvider.notifier).state = value;

    if (value.isEmpty) {
      print('🧹 Limpiando resultados (búsqueda vacía)');
      ref.read(medicationSearchProvider.notifier).clear();
    } else if (MedicationService.isValidQuery(value)) {
      print('🚀 Iniciando búsqueda...');
      ref.read(medicationSearchProvider.notifier).search(value);
    } else {
      print('⏳ Esperando más caracteres (actual: $value)');
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchQuery = ref.watch(searchQueryProvider);
    final searchResults = ref.watch(medicationSearchProvider);

    // Validar si hay suficientes caracteres
    final hasValidQuery = MedicationService.isValidQuery(searchQuery);

    return Scaffold(
      backgroundColor: const Color(0xFFE8F3FF),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Text(
                'Medicamentos',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1D3A62),
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 20),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: _onSearchChanged,
                        decoration: InputDecoration(
                          hintText: 'Ingresa nombre comercial o droga',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 16,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.blue.shade400,
                            size: 28,
                          ),
                          suffixIcon: searchQuery.isNotEmpty
                              ? IconButton(
                            icon: Icon(
                              Icons.close,
                              color: Colors.grey.shade400,
                            ),
                            onPressed: () {
                              _searchController.clear();
                              _onSearchChanged('');
                            },
                          )
                              : null,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1479FF),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF1479FF).withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.tune,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Results
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getHeaderText(searchQuery, hasValidQuery),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1D3A62),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: _buildContent(
                        searchQuery,
                        hasValidQuery,
                        searchResults,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getHeaderText(String query, bool hasValidQuery) {
    if (query.isEmpty) {
      return 'Busca un medicamento';
    } else if (!hasValidQuery) {
      return 'Escribe al menos 3 caracteres';
    } else {
      return 'Mostrando resultados para "$query"';
    }
  }

  Widget _buildContent(
      String query,
      bool hasValidQuery,
      AsyncValue<List<Medication>> searchResults,
      ) {
    // Mostrar mensaje si no hay suficientes caracteres
    if (query.isNotEmpty && !hasValidQuery) {
      return _buildEmptyState(
        icon: Icons.edit,
        message: 'Necesitas escribir al menos 3 caracteres',
      );
    }

    // Mostrar estado vacío si no hay query
    if (query.isEmpty || !hasValidQuery) {
      return _buildEmptyState(
        icon: Icons.search,
        message: 'Escribe para buscar medicamentos',
      );
    }

    // Mostrar resultados según el estado
    return searchResults.when(
      data: (medications) {
        if (medications.isEmpty) {
          return _buildEmptyState(
            icon: Icons.search_off,
            message: 'No se encontraron resultados',
          );
        }

        return ListView.builder(
          itemCount: medications.length,
          itemBuilder: (context, index) {
            return MedicationCard(medication: medications[index]);
          },
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF1479FF),
        ),
      ),
      error: (err, stack) => _buildEmptyState(
        icon: Icons.error_outline,
        message: 'Error al cargar medicamentos',
        isError: true,
      ),
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String message,
    bool isError = false,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: isError ? Colors.red.shade300 : Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 16,
              color: isError ? Colors.red.shade400 : Colors.grey.shade400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}