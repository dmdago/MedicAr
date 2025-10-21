import 'package:flutter/material.dart';
import '../models/medication.dart';

class MedicationCard extends StatelessWidget {
  final Medication medication;

  const MedicationCard({
    Key? key,
    required this.medication,
  }) : super(key: key);

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
          Container(
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
            child: medication.imageUrl != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                medication.imageUrl!,
                fit: BoxFit.cover,
              ),
            )
                : Icon(
              Icons.medication,
              size: 40,
              color: Colors.blue.shade300,
            ),
          ),

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
                    Builder(
                        builder: (context) {
                          print('🎨 Construyendo precio del medicamento: ${medication.name}');
                          return Text(
                            medication.formattedPrice,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1479FF),
                            ),
                          );
                        }
                    ),
                    const SizedBox(width: 8),
                    // Siempre mostrar PAMI
                    Builder(
                        builder: (context) {
                          print('🎨 Construyendo PAMI del medicamento: ${medication.name}');
                          final pamiText = medication.mrp > 0
                              ? medication.formattedMrp
                              : '-';
                          return Text(
                            'PAMI $pamiText',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF1D3A62),
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
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
}