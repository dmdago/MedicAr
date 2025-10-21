import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/medication.dart';
import '../../../core/config/api_config.dart';

class MedicationService {
  // Buscar medicamentos en la API
  Future<List<Medication>> searchMedications({
    required String query,
    int limit = ApiConfig.defaultLimit,
    int offset = ApiConfig.defaultOffset,
  }) async {
    try {
      // Construir URL con parámetros
      final uri = Uri.parse('${ApiConfig.baseUrl}${ApiConfig.remediosEndpoint}')
          .replace(queryParameters: {
        'q': query,
        'limit': limit.toString(),
        'offset': offset.toString(),
      });

      print('🔍 Buscando medicamentos: $uri');
      print('📤 Headers: ${ApiConfig.headers}');

      // Hacer request
      final response = await http.get(
        uri,
        headers: ApiConfig.headers,
      );

      print('📥 Response status: ${response.statusCode}');
      print('📥 Response body: ${response.body}');

      if (response.statusCode == 200) {
        final dynamic jsonData = json.decode(response.body);

        // Manejar diferentes estructuras de respuesta
        List<dynamic> items;
        if (jsonData is List) {
          items = jsonData;
        } else if (jsonData is Map && jsonData.containsKey('items')) {
          items = jsonData['items'] as List;
          print('📦 Encontrados ${items.length} items en response.items');
        } else if (jsonData is Map && jsonData.containsKey('data')) {
          items = jsonData['data'] as List;
        } else if (jsonData is Map && jsonData.containsKey('remedios')) {
          items = jsonData['remedios'] as List;
        } else if (jsonData is Map && jsonData.containsKey('results')) {
          items = jsonData['results'] as List;
        } else {
          print('❌ No se encontró estructura conocida en JSON');
          return [];
        }

        final medications = items.map((item) => Medication.fromJson(item)).toList();
        print('✅ Parseados ${medications.length} medicamentos');
        return medications;
      } else {
        throw Exception('Error al buscar medicamentos: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en searchMedications: $e');
      return [];
    }
  }

  // Validar si la query tiene al menos 3 caracteres válidos
  static bool isValidQuery(String query) {
    // Remover espacios y símbolos, contar solo letras y números
    final validChars = query.replaceAll(RegExp(r'[^\w]'), '');
    return validChars.length >= ApiConfig.minSearchLength;
  }
}