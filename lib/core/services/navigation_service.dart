import 'package:url_launcher/url_launcher.dart';

class NavigationService {
  NavigationService._();

  static Future<bool> openLocation({
    required double latitude,
    required double longitude,
    String? label,
  }) async {
    final encodedLabel = Uri.encodeComponent(label ?? 'Destination');

    final googleMapsUri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
    );

    final geoUri = Uri.parse(
      'geo:$latitude,$longitude?q=$latitude,$longitude($encodedLabel)',
    );

    if (await canLaunchUrl(googleMapsUri)) {
      return launchUrl(
        googleMapsUri,
        mode: LaunchMode.externalApplication,
      );
    }

    if (await canLaunchUrl(geoUri)) {
      return launchUrl(
        geoUri,
        mode: LaunchMode.externalApplication,
      );
    }

    return false;
  }
}