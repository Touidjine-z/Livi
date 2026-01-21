class Medecin {
  final String id;
  final String nom;
  final String specialite;
  final double tarif;
  final List<String> prestations;
  final double avisMoyen;
  final int nombreAvis;
  final String? qrCode;
  final String? telephone;
  final String? adresse;
  final double? latitude;
  final double? longitude;
  final String? region;
  final String? photoUrl;
  final List<String> creneauxLibres; // Format: "HH:mm-HH:mm"

  Medecin({
    required this.id,
    required this.nom,
    required this.specialite,
    required this.tarif,
    required this.prestations,
    this.avisMoyen = 5.0,
    this.nombreAvis = 0,
    this.qrCode,
    this.telephone,
    this.adresse,
    this.latitude,
    this.longitude,
    this.region,
    this.photoUrl,
    this.creneauxLibres = const [],
  });

  // Conversion depuis JSON (Firebase)
  factory Medecin.fromJson(Map<String, dynamic> json) {
    return Medecin(
      id: json['id'] ?? '',
      nom: json['nom'] ?? '',
      specialite: json['specialite'] ?? '',
      tarif: (json['tarif'] ?? 0).toDouble(),
      prestations: List<String>.from(json['prestations'] ?? []),
      avisMoyen: (json['avisMoyen'] ?? 5.0).toDouble(),
      nombreAvis: json['nombreAvis'] ?? 0,
      qrCode: json['qrCode'],
      telephone: json['telephone'],
      adresse: json['adresse'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      region: json['region'],
      photoUrl: json['photoUrl'],
      creneauxLibres: List<String>.from(json['creneauxLibres'] ?? []),
    );
  }

  // Conversion vers JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'specialite': specialite,
      'tarif': tarif,
      'prestations': prestations,
      'avisMoyen': avisMoyen,
      'nombreAvis': nombreAvis,
      'qrCode': qrCode,
      'telephone': telephone,
      'adresse': adresse,
      'latitude': latitude,
      'longitude': longitude,
      'region': region,
      'photoUrl': photoUrl,
      'creneauxLibres': creneauxLibres,
    };
  }
}
