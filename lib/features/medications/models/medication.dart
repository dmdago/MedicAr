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

  // Crear desde JSON de la API
  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      name: json['nombre'] ?? json['name'] ?? 'Sin nombre',
      type: json['tipo'] ?? json['type'] ?? json['droga'] ?? 'Sin tipo',
      price: _parsePrice(json['precio'] ?? json['price']),
      mrp: _parsePrice(json['precio_sugerido'] ?? json['mrp'] ?? json['precio']),
      imageUrl: json['imagen'] ?? json['image_url'],
    );
  }

  // Helper para parsear precios de diferentes formatos
  static double _parsePrice(dynamic price) {
    if (price == null) return 0.0;
    if (price is double) return price;
    if (price is int) return price.toDouble();
    if (price is String) {
      // Remover símbolos de moneda y parsear
      final cleaned = price.replaceAll(RegExp(r'[^\d.]'), '');
      return double.tryParse(cleaned) ?? 0.0;
    }
    return 0.0;
  }

  // Convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'price': price,
      'mrp': mrp,
      'imageUrl': imageUrl,
    };
  }
}