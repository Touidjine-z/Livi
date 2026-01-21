enum StatutRendezVous {
  confirme,
  en_attente,
  termine,
  annule,
}

class RendezVous {
  final String id;
  final String patientId;
  final String medecinId;
  final DateTime dateHeure;
  final String? codeQR;
  final StatutRendezVous statut;
  final String? notes;
  final DateTime? dateCreation;
  final double? dureeMinutes;
  final String? nomPatient;
  final String? emailPatient;
  final String? telephonePatient;

  RendezVous({
    required this.id,
    required this.patientId,
    required this.medecinId,
    required this.dateHeure,
    this.codeQR,
    this.statut = StatutRendezVous.en_attente,
    this.notes,
    this.dateCreation,
    this.dureeMinutes = 15,
    this.nomPatient,
    this.emailPatient,
    this.telephonePatient,
  });

  // Getter pour véifier si le RDV est dans le passé
  bool get estTermine => DateTime.now().isAfter(dateHeure);

  // Getter pour formater la date et heure
  String get dateHeureFormatee {
    return '${dateHeure.day}/${dateHeure.month}/${dateHeure.year} à ${dateHeure.hour}:${dateHeure.minute.toString().padLeft(2, '0')}';
  }

  // Conversion depuis JSON
  factory RendezVous.fromJson(Map<String, dynamic> json) {
    return RendezVous(
      id: json['id'] ?? '',
      patientId: json['patientId'] ?? '',
      medecinId: json['medecinId'] ?? '',
      dateHeure: DateTime.parse(json['dateHeure']),
      codeQR: json['codeQR'],
      statut: StatutRendezVous.values.firstWhere(
        (e) => e.toString() == 'StatutRendezVous.${json['statut'] ?? 'en_attente'}',
        orElse: () => StatutRendezVous.en_attente,
      ),
      notes: json['notes'],
      dateCreation: json['dateCreation'] != null
          ? DateTime.parse(json['dateCreation'])
          : null,
      dureeMinutes: (json['dureeMinutes'] ?? 15).toDouble(),
      nomPatient: json['nomPatient'],
      emailPatient: json['emailPatient'],
      telephonePatient: json['telephonePatient'],
    );
  }

  // Conversion vers JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'medecinId': medecinId,
      'dateHeure': dateHeure.toIso8601String(),
      'codeQR': codeQR,
      'statut': statut.toString().split('.').last,
      'notes': notes,
      'dateCreation': dateCreation?.toIso8601String(),
      'dureeMinutes': dureeMinutes,
      'nomPatient': nomPatient,
      'emailPatient': emailPatient,
      'telephonePatient': telephonePatient,
    };
  }
}
