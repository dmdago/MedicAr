class ApiConfig {
  // Base URL de la API con HTTPS
  static const String baseUrl = 'https://langosta.app:3000';

  // API Key
  static const String apiKey = 'change-me-key';

  // Endpoints
  static const String remediosEndpoint = '/remedios';
  static const String imagesEndpoint = '/images/remedios';

  // Parámetros de búsqueda
  static const int defaultLimit = 10;
  static const int defaultOffset = 0;
  static const int minSearchLength = 3; // Mínimo de caracteres para buscar

  // Headers
  static Map<String, String> get headers => {
    'x-api-key': apiKey,
    'Content-Type': 'application/json',
  };

  // Helper para construir URL de imagen dado un código de barras
  static String getImageUrl(String barcode) {
    return '$baseUrl$imagesEndpoint/$barcode.jpg';
  }
}