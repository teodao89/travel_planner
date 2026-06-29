import 'dart:convert';

import 'package:http/http.dart' as http;

class GeocodingResult {
  final String address;
  final double latitude;
  final double longitude;

  const GeocodingResult({
    required this.address,
    required this.latitude,
    required this.longitude,
  });
}

class GeocodingService {
  GeocodingService._();

  static Future<GeocodingResult?> search(String query) async {
    final trimmedQuery = query.trim();

    if (trimmedQuery.isEmpty) {
      return null;
    }

    final uri = Uri.https(
      'nominatim.openstreetmap.org',
      '/search',
      {
        'q': trimmedQuery,
        'format': 'json',
        'limit': '1',
        'addressdetails': '1',
      },
    );

    final response = await http.get(
      uri,
      headers: {
        'User-Agent': 'travel_planner_app',
      },
    );

    if (response.statusCode != 200) {
      return null;
    }

    final data = jsonDecode(response.body) as List<dynamic>;

    if (data.isEmpty) {
      return null;
    }

    final item = data.first as Map<String, dynamic>;

    return GeocodingResult(
      address: item['display_name'] as String,
      latitude: double.parse(item['lat'] as String),
      longitude: double.parse(item['lon'] as String),
    );
  }
}