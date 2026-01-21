class Avis {
  final String id;
  final String medecinId;
  final String patientId;
  final int note; // 1 à 5
  final String? commentaire;
  final DateTime? dateCreation;
  final String? nomPatient;

  Avis({
    required this.id,
    required this.medecinId,
    required this.patientId,
    required this.note,
    this.commentaire,
    this.dateCreation,
    this.nomPatient,
  });

  // Validation de la note
  bool get isValid => note >= 1 && note <= 5;

  // Conversion depuis JSON
  factory Avis.fromJson(Map<String, dynamic> json) {
    return Avis(
      id: json['id'] ?? '',
      medecinId: json['medecinId'] ?? '',
      patientId: json['patientId'] ?? '',
      note: json['note'] ?? 5,
      commentaire: json['commentaire'],
      dateCreation: json['dateCreation'] != null
          ? DateTime.parse(json['dateCreation'])
          : null,
      nomPatient: json['nomPatient'],
    );
  }

  // Conversion vers JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'medecinId': medecinId,
      'patientId': patientId,
      'note': note,
      'commentaire': commentaire,
      'dateCreation': dateCreation?.toIso8601String(),
      'nomPatient': nomPatient,
    };
  }
}
