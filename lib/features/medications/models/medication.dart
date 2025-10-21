class Medication {
  final String name;
  final String type;
  final double price;
  final double mrp;
  final String? imageUrl;

  Medication({
    required this.name,
    required this.type,
    required this.price,
    required this.mrp,
    this.imageUrl,
  });

  // Datos de ejemplo
  static List<Medication> getMockData() {
    return [
      Medication(
        name: 'Ibuprofeno',
        type: 'Analgésico',
        price: 10.00,
        mrp: 30.00,
      ),
      Medication(
        name: 'Paracetamol',
        type: 'Analgésico',
        price: 8.50,
        mrp: 25.00,
      ),
      Medication(
        name: 'Amoxicilina',
        type: 'Antibiótico',
        price: 15.00,
        mrp: 45.00,
      ),
      Medication(
        name: 'Omeprazol',
        type: 'Antiácido',
        price: 12.00,
        mrp: 35.00,
      ),
      Medication(
        name: 'Loratadina',
        type: 'Antihistamínico',
        price: 9.00,
        mrp: 28.00,
      ),
      Medication(
        name: 'Aspirina',
        type: 'Analgésico',
        price: 7.50,
        mrp: 22.00,
      ),
    ];
  }
}