import 'package:geolocator/geolocator.dart';

class MapUtils {
  // Obtenir la position actuelle de l'utilisateur
  static Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Vérifier si les services de localisation sont activés
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    return await Geolocator.getCurrentPosition();
  }

  // Calculer la distance entre deux points (en km)
  static double calculateDistance({
    required double lat1,
    required double lon1,
    required double lat2,
    required double lon2,
  }) {
    double distance = Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
    return distance / 1000; // Convertir en km
  }

  // Obtenir la région à partir des coordonnées
  static Future<String?> getRegionFromCoordinates({
    required double latitude,
    required double longitude,
  }) async {
    // Cette fonction peut être implémentée avec un service de géocodage
    // Pour l'instant, retourner une région fictive
    return 'Région';
  }

  // Vérifier si un point est à proximité d'une région
  static bool isNearRegion({
    required double userLat,
    required double userLon,
    required double regionLat,
    required double regionLon,
    required double radiusKm,
  }) {
    double distance = calculateDistance(
      lat1: userLat,
      lon1: userLon,
      lat2: regionLat,
      lon2: regionLon,
    );
    return distance <= radiusKm;
  }

  // Filtrer les médecins par région/proximité
  static List<dynamic> filterByDistance({
    required List<dynamic> medecins,
    required double userLat,
    required double userLon,
    required double radiusKm,
  }) {
    return medecins.where((medecin) {
      if (medecin.latitude == null || medecin.longitude == null) {
        return false;
      }
      double distance = calculateDistance(
        lat1: userLat,
        lon1: userLon,
        lat2: medecin.latitude!,
        lon2: medecin.longitude!,
      );
      return distance <= radiusKm;
    }).toList();
  }

  // Trier les médecins par distance
  static void sortByDistance({
    required List<dynamic> medecins,
    required double userLat,
    required double userLon,
  }) {
    medecins.sort((a, b) {
      if (a.latitude == null ||
          a.longitude == null ||
          b.latitude == null ||
          b.longitude == null) {
        return 0;
      }

      double distanceA = calculateDistance(
        lat1: userLat,
        lon1: userLon,
        lat2: a.latitude!,
        lon2: b.longitude!,
      );

      double distanceB = calculateDistance(
        lat1: userLat,
        lon1: userLon,
        lat2: b.latitude!,
        lon2: b.longitude!,
      );

      return distanceA.compareTo(distanceB);
    });
  }

  // Obtenir les régions algériennes
  static List<String> getAlgerianRegions() {
    return [
      'Alger',
      'Annaba',
      'Batna',
      'Béjaïa',
      'Blida',
      'Bordj Bou Arreridj',
      'Bouira',
      'Boumerdès',
      'Chlef',
      'Constantine',
      'Djelfa',
      'El Bayadh',
      'El Oued',
      'El Taref',
      'Ghardaia',
      'Guelma',
      'Illizi',
      'Jijel',
      'Khenchela',
      'Laghouat',
      'Mascara',
      'Médéa',
      'Mila',
      'Mostaganem',
      'M\'Sila',
      'Oran',
      'Ouargla',
      'Oum El Bouaghi',
      'Saïda',
      'Sétif',
      'Sidi Bel Abbès',
      'Skikda',
      'Souk Ahras',
      'Tamanghasset',
      'Tébessa',
      'Tiaret',
      'Tindouf',
      'Tipasa',
      'Tissemsilt',
      'Tizi Ouzou',
      'Tamanrasset',
      'Tlemcen',
    ];
  }
}
