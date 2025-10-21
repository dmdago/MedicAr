class Medication {
  final String name;
  final String type;
  final String laboratory;
  final double price;
  final double mrp;
  final String? imageUrl;

  Medication({
    required this.name,
    required this.type,
    required this.laboratory,
    required this.price,
    required this.mrp,
    this.imageUrl,
  });

  // Crear desde JSON de la API
  factory Medication.fromJson(Map<String, dynamic> json) {
    print('🔧 Parseando medicamento: ${json['nombre']}');

    return Medication(
      name: json['nombre'] ?? json['name'] ?? 'Sin nombre',
      type: json['droga'] ?? json['tipo'] ?? json['type'] ?? 'Sin tipo',
      laboratory: json['laboratorio'] ?? json['laboratory'] ?? 'Sin laboratorio',
      price: _parsePrice(json['precio'] ?? json['price']),
      mrp: _parsePrice(json['precio_pami'] ?? json['mrp'] ?? json['precio_sugerido'] ?? json['precio']),
      imageUrl: json['imagen'] ?? json['image_url'],
    );
  }

  // Helper para parsear precios de diferentes formatos
  static double _parsePrice(dynamic price) {
    if (price == null) return 0.0;

    // Si es un número, convertir directamente (sin dividir)
    if (price is double) return price;
    if (price is int) return price.toDouble();

    // Si es string, limpiar y parsear
    if (price is String) {
      // Remover símbolos de moneda y espacios, pero mantener el punto decimal
      final cleaned = price.replaceAll(RegExp(r'[^\d.]'), '');
      final parsed = double.tryParse(cleaned) ?? 0.0;
      return parsed;
    }

    return 0.0;
  }

  // Formatear precio para mostrar (formato argentino: separador decimal coma)
  String get formattedPrice {
    print('🏷️ Formateando precio: $price');
    final result = _formatPrice(price);
    print('🏷️ Resultado: $result');
    return result;
  }

  // Formatear MRP para mostrar
  String get formattedMrp {
    print('🏷️ Formateando MRP: $mrp');
    final result = _formatPrice(mrp);
    print('🏷️ Resultado MRP: $result');
    return result;
  }

  // Helper privado para formatear precios
  static String _formatPrice(double amount) {
    print('💰 _formatPrice recibió: $amount');

    final intPart = amount.floor();

    print('💰 Número entero: $intPart');

    // Formatear parte entera con separador de miles (punto)
    String result = intPart.toString();
    print('💰 result inicial: $result');

    if (intPart >= 1000) {
      result = result.replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
            (match) => '${match[1]}.',
      );
      print('💰 result después de separador de miles: $result');
    }

    // Agregar símbolo de peso
    result = '\$' + result;
    print('💰 result final: $result');

    print('💰 Retornando: $result');
    return result;
  }

  // Convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'laboratory': laboratory,
      'price': price,
      'mrp': mrp,
      'imageUrl': imageUrl,
    };
  }
}