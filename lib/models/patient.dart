class Patient {
  final String id;
  final String nom;
  final String prenom;
  final String email;
  final String? telephone;
  final String? adresse;
  final String? region;
  final DateTime? dateCreation;
  final String? photoUrl;

  Patient({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    this.telephone,
    this.adresse,
    this.region,
    this.dateCreation,
    this.photoUrl,
  });

  // Getter pour nom complet
  String get nomComplet => '$prenom $nom';

  // Conversion depuis JSON (Firebase)
  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] ?? '',
      nom: json['nom'] ?? '',
      prenom: json['prenom'] ?? '',
      email: json['email'] ?? '',
      telephone: json['telephone'],
      adresse: json['adresse'],
      region: json['region'],
      dateCreation: json['dateCreation'] != null
          ? DateTime.parse(json['dateCreation'])
          : null,
      photoUrl: json['photoUrl'],
    );
  }

  // Conversion vers JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'telephone': telephone,
      'adresse': adresse,
      'region': region,
      'dateCreation': dateCreation?.toIso8601String(),
      'photoUrl': photoUrl,
    };
  }
}
