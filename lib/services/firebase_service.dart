import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/medecin.dart';
import '../models/patient.dart';
import '../models/rendez_vous.dart';
import '../models/avis.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ==================== MÉDECINS ====================

  // Obtenir tous les médecins
  Future<List<Medecin>> getAllMedecins() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('medecins').get();
      return snapshot.docs
          .map((doc) => Medecin.fromJson({...doc.data() as Map<String, dynamic>, 'id': doc.id}))
          .toList();
    } catch (e) {
      throw Exception('Erreur lors du chargement des médecins: $e');
    }
  }

  // Obtenir un médecin par ID
  Future<Medecin?> getMedecinById(String id) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('medecins').doc(id).get();
      if (doc.exists) {
        return Medecin.fromJson({...doc.data() as Map<String, dynamic>, 'id': doc.id});
      }
      return null;
    } catch (e) {
      throw Exception('Erreur lors du chargement du médecin: $e');
    }
  }

  // Ajouter un médecin
  Future<String> addMedecin(Medecin medecin) async {
    try {
      DocumentReference doc = await _firestore.collection('medecins').add(medecin.toJson());
      return doc.id;
    } catch (e) {
      throw Exception('Erreur lors de l\'ajout du médecin: $e');
    }
  }

  // Mettre à jour un médecin
  Future<void> updateMedecin(String id, Medecin medecin) async {
    try {
      await _firestore.collection('medecins').doc(id).update(medecin.toJson());
    } catch (e) {
      throw Exception('Erreur lors de la mise à jour du médecin: $e');
    }
  }

  // Supprimer un médecin
  Future<void> deleteMedecin(String id) async {
    try {
      await _firestore.collection('medecins').doc(id).delete();
    } catch (e) {
      throw Exception('Erreur lors de la suppression du médecin: $e');
    }
  }

  // Rechercher des médecins par spécialité
  Future<List<Medecin>> searchBySpecialite(String specialite) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('medecins')
          .where('specialite', isEqualTo: specialite)
          .get();
      return snapshot.docs
          .map((doc) => Medecin.fromJson({...doc.data() as Map<String, dynamic>, 'id': doc.id}))
          .toList();
    } catch (e) {
      throw Exception('Erreur lors de la recherche: $e');
    }
  }

  // ==================== PATIENTS ====================

  // Obtenir un patient par ID
  Future<Patient?> getPatientById(String id) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('patients').doc(id).get();
      if (doc.exists) {
        return Patient.fromJson({...doc.data() as Map<String, dynamic>, 'id': doc.id});
      }
      return null;
    } catch (e) {
      throw Exception('Erreur lors du chargement du patient: $e');
    }
  }

  // Ajouter un patient
  Future<String> addPatient(Patient patient) async {
    try {
      DocumentReference doc = await _firestore.collection('patients').add(patient.toJson());
      return doc.id;
    } catch (e) {
      throw Exception('Erreur lors de l\'ajout du patient: $e');
    }
  }

  // Mettre à jour un patient
  Future<void> updatePatient(String id, Patient patient) async {
    try {
      await _firestore.collection('patients').doc(id).update(patient.toJson());
    } catch (e) {
      throw Exception('Erreur lors de la mise à jour du patient: $e');
    }
  }

  // ==================== RENDEZ-VOUS ====================

  // Obtenir tous les rendez-vous
  Future<List<RendezVous>> getAllRendezVous() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('rendez_vous')
          .orderBy('dateHeure', descending: false)
          .get();
      return snapshot.docs
          .map((doc) => RendezVous.fromJson({...doc.data() as Map<String, dynamic>, 'id': doc.id}))
          .toList();
    } catch (e) {
      throw Exception('Erreur lors du chargement des rendez-vous: $e');
    }
  }

  // Obtenir les rendez-vous d'un patient
  Future<List<RendezVous>> getRendezVousByPatient(String patientId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('rendez_vous')
          .where('patientId', isEqualTo: patientId)
          .orderBy('dateHeure', descending: false)
          .get();
      return snapshot.docs
          .map((doc) => RendezVous.fromJson({...doc.data() as Map<String, dynamic>, 'id': doc.id}))
          .toList();
    } catch (e) {
      throw Exception('Erreur lors du chargement des rendez-vous: $e');
    }
  }

  // Obtenir les rendez-vous d'un médecin
  Future<List<RendezVous>> getRendezVousByMedecin(String medecinId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('rendez_vous')
          .where('medecinId', isEqualTo: medecinId)
          .orderBy('dateHeure', descending: false)
          .get();
      return snapshot.docs
          .map((doc) => RendezVous.fromJson({...doc.data() as Map<String, dynamic>, 'id': doc.id}))
          .toList();
    } catch (e) {
      throw Exception('Erreur lors du chargement des rendez-vous: $e');
    }
  }

  // Ajouter un rendez-vous
  Future<String> addRendezVous(RendezVous rendezVous) async {
    try {
      DocumentReference doc = await _firestore.collection('rendez_vous').add(rendezVous.toJson());
      return doc.id;
    } catch (e) {
      throw Exception('Erreur lors de la création du rendez-vous: $e');
    }
  }

  // Mettre à jour un rendez-vous
  Future<void> updateRendezVous(String id, RendezVous rendezVous) async {
    try {
      await _firestore.collection('rendez_vous').doc(id).update(rendezVous.toJson());
    } catch (e) {
      throw Exception('Erreur lors de la mise à jour du rendez-vous: $e');
    }
  }

  // Annuler un rendez-vous
  Future<void> cancelRendezVous(String id) async {
    try {
      await _firestore.collection('rendez_vous').doc(id).update({
        'statut': 'annule',
      });
    } catch (e) {
      throw Exception('Erreur lors de l\'annulation du rendez-vous: $e');
    }
  }

  // Obtenir les rendez-vous disponibles pour une date et un médecin
  Future<List<String>> getAvailableSlots(String medecinId, DateTime date) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('rendez_vous')
          .where('medecinId', isEqualTo: medecinId)
          .where('statut', whereIn: ['confirme', 'en_attente'])
          .get();

      // Récupérer tous les créneaux du jour
      List<String> allSlots = [];
      for (int i = 9; i < 17; i++) {
        for (int j = 0; j < 60; j += 15) {
          allSlots.add('${i.toString().padLeft(2, '0')}:${j.toString().padLeft(2, '0')}');
        }
      }

      // Retirer les créneaux réservés
      Set<String> occupiedSlots = {};
      for (var doc in snapshot.docs) {
        RendezVous rv = RendezVous.fromJson({...doc.data() as Map<String, dynamic>, 'id': doc.id});
        if (DateUtils.isSameDay(rv.dateHeure, date)) {
          occupiedSlots.add(DateUtils.formatTime(rv.dateHeure, format: 'HH:mm'));
        }
      }

      return allSlots.where((slot) => !occupiedSlots.contains(slot)).toList();
    } catch (e) {
      throw Exception('Erreur lors de la récupération des créneaux: $e');
    }
  }

  // ==================== AVIS ====================

  // Ajouter un avis
  Future<String> addAvis(Avis avis) async {
    try {
      DocumentReference doc = await _firestore.collection('avis').add(avis.toJson());

      // Mettre à jour la note moyenne du médecin
      await _updateMedecinRating(avis.medecinId);

      return doc.id;
    } catch (e) {
      throw Exception('Erreur lors de l\'ajout de l\'avis: $e');
    }
  }

  // Obtenir les avis d'un médecin
  Future<List<Avis>> getAvisByMedecin(String medecinId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('avis')
          .where('medecinId', isEqualTo: medecinId)
          .orderBy('dateCreation', descending: true)
          .get();
      return snapshot.docs
          .map((doc) => Avis.fromJson({...doc.data() as Map<String, dynamic>, 'id': doc.id}))
          .toList();
    } catch (e) {
      throw Exception('Erreur lors du chargement des avis: $e');
    }
  }

  // Mettre à jour la note moyenne d'un médecin
  Future<void> _updateMedecinRating(String medecinId) async {
    try {
      List<Avis> avis = await getAvisByMedecin(medecinId);
      if (avis.isEmpty) return;

      double averageRating =
          avis.fold(0, (sum, a) => sum + a.note) / avis.length;
      int nombreAvis = avis.length;

      await _firestore.collection('medecins').doc(medecinId).update({
        'avisMoyen': averageRating,
        'nombreAvis': nombreAvis,
      });
    } catch (e) {
      throw Exception('Erreur lors de la mise à jour de la note: $e');
    }
  }
}

// Utilitaire pour les dates (à importer)
import '../utils/date_utils.dart' as DateUtils;
