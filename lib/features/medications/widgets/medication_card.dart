import 'package:flutter/material.dart';
import '../models/medication.dart';

class MedicationCard extends StatelessWidget {
  final Medication medication;

  const MedicationCard({
    Key? key,
    required this.medication,
  }) : super(key: key);

  // Construir URL de imagen solo si hay código de barras válido
  String? _getImageUrl() {
    print('🔍 === DEBUG IMAGEN ===');
    print('Medicamento: ${medication.name}');
    print('Barcode: ${medication.barcode}');
    print('ImageUrl: ${medication.imageUrl}');

    try {
      if (medication.barcode != null && medication.barcode!.isNotEmpty) {
        final url = 'https://langosta.app:3000/images/remedios/${medication.barcode}.jpg';
        print('✅ URL construida: $url');
        return url;
      }

      if (medication.imageUrl != null && medication.imageUrl!.isNotEmpty) {
        print('✅ Usando imageUrl: ${medication.imageUrl}');
        return medication.imageUrl;
      }

      print('❌ No hay URL de imagen disponible');
      return null;
    } catch (e) {
      print('⚠️ Error construyendo URL: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F3FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.blue.shade100,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Imagen del medicamento
          _buildMedicationImage(),

          const SizedBox(width: 16),

          // Información del medicamento
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  medication.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1D3A62),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  medication.type,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  medication.laboratory,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      medication.formattedPrice,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1479FF),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'PAMI ${medication.mrp > 0 ? medication.formattedMrp : '-'}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF1D3A62),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationImage() {
    final imageUrl = _getImageUrl();

    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.blue.shade200,
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: imageUrl != null && imageUrl.isNotEmpty
            ? Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            print('❌ ERROR cargando imagen: $imageUrl');
            print('Error: $error');
            return _buildDefaultIcon();
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              print('✅ Imagen cargada exitosamente: $imageUrl');
              return child;
            }
            print('⏳ Cargando imagen: ${loadingProgress.cumulativeBytesLoaded} / ${loadingProgress.expectedTotalBytes ?? '?'}');
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                    : null,
                strokeWidth: 2,
                color: Colors.blue.shade300,
              ),
            );
          },
        )
            : _buildDefaultIcon(),
      ),
    );
  }

  Widget _buildDefaultIcon() {
    print('🔵 Mostrando ícono por defecto');
    return Icon(
      Icons.medication,
      size: 40,
      color: Colors.blue.shade300,
    );
  }
}