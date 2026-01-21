import '../models/medecin.dart';
import '../models/patient.dart';
import '../models/rendez_vous.dart';

class MockData {
  // Données de test pour les médecins
  static List<Medecin> mockMedecins = [
    Medecin(
      id: 'med_001',
      nom: 'Dr. Ahmed Ben Ali',
      specialite: 'Cardiologue',
      tarif: 2000,
      prestations: ['Consultation', 'ECG', 'Échographie cardiaque'],
      avisMoyen: 4.8,
      nombreAvis: 45,
      telephone: '+213551234567',
      adresse: 'Rue de la Paix, Alger',
      latitude: 36.7372,
      longitude: 3.0869,
      region: 'Alger',
      photoUrl: null,
      creneauxLibres: ['09:00', '09:30', '10:00', '14:00', '15:00'],
    ),
    Medecin(
      id: 'med_002',
      nom: 'Dr. Fatima Khadri',
      specialite: 'Dermatologue',
      tarif: 1500,
      prestations: ['Consultation', 'Laser', 'Dermatoscopie'],
      avisMoyen: 4.9,
      nombreAvis: 62,
      telephone: '+213551234568',
      adresse: 'Boulevard Ernesto Che Guevara, Alger',
      latitude: 36.7489,
      longitude: 3.0590,
      region: 'Alger',
      creneauxLibres: ['10:00', '10:30', '11:00', '15:30', '16:00'],
    ),
    Medecin(
      id: 'med_003',
      nom: 'Dr. Mohamed Zaki',
      specialite: 'Neurologue',
      tarif: 2500,
      prestations: ['Consultation', 'EEG', 'IRM'],
      avisMoyen: 4.7,
      nombreAvis: 38,
      telephone: '+213551234569',
      adresse: 'Avenue Frantz Fanon, Alger',
      latitude: 36.7538,
      longitude: 3.0588,
      region: 'Alger',
      creneauxLibres: ['09:00', '10:00', '11:00', '14:00'],
    ),
    Medecin(
      id: 'med_004',
      nom: 'Dr. Leila Bouazza',
      specialite: 'Gynécologue',
      tarif: 2000,
      prestations: ['Consultation', 'Échographie', 'Vaccin'],
      avisMoyen: 5.0,
      nombreAvis: 53,
      telephone: '+213551234570',
      adresse: 'Rue Mohamed Belouizdad, Alger',
      latitude: 36.7468,
      longitude: 3.0760,
      region: 'Alger',
      creneauxLibres: ['09:30', '10:30', '14:30', '15:30'],
    ),
    Medecin(
      id: 'med_005',
      nom: 'Dr. Karim Mansour',
      specialite: 'Orthopédiste',
      tarif: 1800,
      prestations: ['Consultation', 'Radiographie', 'Immobilisation'],
      avisMoyen: 4.6,
      nombreAvis: 41,
      telephone: '+213551234571',
      adresse: 'Rue Ali Khodja, Oran',
      latitude: 35.7412,
      longitude: -0.6417,
      region: 'Oran',
      creneauxLibres: ['10:00', '11:00', '14:00', '15:00', '16:00'],
    ),
  ];

  // Données de test pour les patients
  static Patient mockPatient = Patient(
    id: 'pat_001',
    nom: 'Cherif',
    prenom: 'Zaki',
    email: 'zaki@example.com',
    telephone: '+213551111111',
    adresse: 'Rue de la Liberté, Alger',
    region: 'Alger',
    dateCreation: DateTime.now(),
  );

  // Données de test pour les rendez-vous
  static List<RendezVous> mockRendezVous = [
    RendezVous(
      id: 'rv_001',
      patientId: 'pat_001',
      medecinId: 'med_001',
      dateHeure: DateTime.now().add(Duration(days: 2, hours: 10)),
      codeQR: 'RV:rv_001:1234567890',
      statut: StatutRendezVous.confirme,
      nomPatient: 'Zaki Cherif',
      emailPatient: 'zaki@example.com',
      telephonePatient: '+213551111111',
    ),
    RendezVous(
      id: 'rv_002',
      patientId: 'pat_001',
      medecinId: 'med_002',
      dateHeure: DateTime.now().add(Duration(days: 5, hours: 14)),
      codeQR: 'RV:rv_002:1234567891',
      statut: StatutRendezVous.en_attente,
      nomPatient: 'Zaki Cherif',
      emailPatient: 'zaki@example.com',
      telephonePatient: '+213551111111',
    ),
  ];

  // Régions algériennes pour les filtres
  static List<String> regions = [
    'Alger',
    'Oran',
    'Constantine',
    'Annaba',
    'Blida',
    'Béjaïa',
    'Sétif',
    'Tizi Ouzou',
  ];

  // Spécialités médicales
  static List<String> specialites = [
    'Cardiologue',
    'Dermatologue',
    'Neurologue',
    'Gynécologue',
    'Orthopédiste',
    'Généraliste',
    'Pédiatre',
    'Psychiatre',
    'Ophtalmologue',
    'Gastro-entérologue',
  ];
}
