# 🏥 Rendez-Vous Santé 

Une application mobile Flutter pour réserver des rendez-vous avec les médecins.

## ✨ Fonctionnalités

- 📍 **Localisation des médecins** : Carte interactive avec tous les médecins disponibles
- 🔍 **Recherche avancée** : Filtrer par région, spécialité, tarif
- 📅 **Calendrier intelligent** : Réservation par créneaux de 15 minutes
- 🔐 **QR Code** : Génération et scan de codes QR pour validation des rendez-vous
- 📧 **Email** : Confirmation et rappels automatiques
- 💬 **Avis** : Laisser des commentaires et notes après la consultation
- 🔔 **Notifications** : Rappels 30 minutes avant le rendez-vous
- 💾 **Synchronisation** : Stockage local SQLite avec Firebase Cloud Firestore

## 🏗️ Architecture du Projet

```
lib/
├── main.dart                 # Point d'entrée de l'appli
├── models/                   # Modèles de données
│   ├── medecin.dart
│   ├── patient.dart
│   ├── rendez_vous.dart
│   └── avis.dart
├── services/                 # Services (API, Firebase, Email, QR)
│   ├── firebase_service.dart
│   ├── email_service.dart
│   └── qr_service.dart
├── screens/                  # Pages de l'application
│   ├── splash_screen.dart
│   ├── login_screen.dart
│   ├── map_screen.dart
│   ├── medecin_detail_screen.dart
│   ├── calendrier_screen.dart
│   ├── reservation_screen.dart
│   └── avis_screen.dart
├── widgets/                  # Composants réutilisables
│   ├── medecin_card.dart
│   ├── calendrier_widget.dart
│   └── qr_code_widget.dart
├── utils/                    # Utilitaires
│   ├── date_utils.dart
│   ├── notification_utils.dart
│   ├── map_utils.dart
│   └── validation_utils.dart
└── constants/                # Constantes
    ├── colors.dart
    ├── strings.dart
    └── dimensions.dart
```

## 🚀 Installation

### Prérequis
- Flutter 3.0+ ([Installation](https://flutter.dev/docs/get-started/install))
- Firebase Account ([Setup](https://firebase.google.com/))
- Compte Google Maps API

### Étapes

1. **Cloner le projet**
   ```bash
   git clone <repository-url>
   cd rendez_vous_sante
   ```

2. **Installer les dépendances**
   ```bash
   flutter pub get
   ```

3. **Configurer Firebase**
   - Créer un projet sur [Firebase Console](https://console.firebase.google.com)
   - Générer les configurations pour Android et iOS
   - Placer les fichiers de configuration :
     - Android: `android/app/google-services.json`
     - iOS: `ios/Runner/GoogleService-Info.plist`

4. **Configurer Google Maps**
   - Générer une clé API Google Maps
   - Android: Ajouter dans `android/app/build.gradle`
   - iOS: Ajouter dans `ios/Runner/Info.plist`

5. **Mettre à jour les configurations Firebase**
   - Éditer `lib/firebase_options.dart` avec vos clés API
   - Éditer `lib/services/email_service.dart` avec vos paramètres email

6. **Lancer l'application**
   ```bash
   flutter run
   ```

## 📋 Modèles de Données

### Médecin
```dart
- id: String
- nom: String
- specialite: String
- tarif: double
- prestations: List<String>
- avisMoyen: double (5.0 par défaut)
- nombreAvis: int (0 par défaut)
- telephone: String?
- adresse: String?
- latitude: double?
- longitude: double?
- region: String?
- photoUrl: String?
- creneauxLibres: List<String>
```

### Patient
```dart
- id: String
- nom: String
- prenom: String
- email: String
- telephone: String?
- adresse: String?
- region: String?
- dateCreation: DateTime?
- photoUrl: String?
```

### Rendez-Vous
```dart
- id: String
- patientId: String
- medecinId: String
- dateHeure: DateTime
- codeQR: String?
- statut: enum (confirme, en_attente, termine, annule)
- notes: String?
- dureeMinutes: double
```

### Avis
```dart
- id: String
- medecinId: String
- patientId: String
- note: int (1-5)
- commentaire: String?
- dateCreation: DateTime?
```

## 🔧 Configuration des Services

### Firebase Firestore
Structure des collections:
```
medecins/
  {id}/
    - nom, specialite, tarif, ...

patients/
  {id}/
    - nom, email, ...

rendez_vous/
  {id}/
    - patientId, medecinId, dateHeure, ...

avis/
  {id}/
    - medecinId, patientId, note, ...
```

### Email Service
Utilise Gmail SMTP. À configurer dans `email_service.dart`:
```dart
static const String senderEmail = 'your-email@gmail.com';
static const String senderPassword = 'your-app-password';
```

### Google Maps
Clé API requise pour afficher la carte et les marqueurs.

## 📱 Fonctionnalités Principales

### 1. Écran de Démarrage
- Logo et titre de l'application
- Initialisation de Firebase

### 2. Connexion
- Email et mot de passe
- Validation des champs
- Récupération de mot de passe

### 3. Carte
- Affichage des médecins sur la carte
- Filtrage par région
- Recherche par nom/spécialité
- Calcul de distance

### 4. Détails Médecin
- Informations complètes
- Avis et note moyenne
- Calendrier de disponibilités
- Bouton de réservation

### 5. Réservation
- Sélection de créneaux 15 min
- Ajout de notes
- Confirmation avec QR code
- Envoi d'email

### 6. Avis
- Évaluation 1-5 étoiles
- Commentaire texte
- Mise à jour de la note médecin

## 🔒 Sécurité

- Authentification Firebase
- Validations côté client et serveur
- Stockage sécurisé des données sensibles
- HTTPS pour toutes les communications

## 📞 Support

Pour toute question ou problème, contactez:
- Email: /
- Issues: /

## 📄 Licence

Ce projet est sous licence MIT. Voir `LICENSE` pour plus de détails.

## 🎯 Prochaines Étapes

- [ ] Implémenter l'authentification Firebase complète
- [ ] Connecter la base de données Firestore
- [ ] Implémenter les notifications
- [ ] Tests unitaires et intégration
- [ ] Optimisation des performances
- [ ] Support du dark mode
- [ ] Localisation multilingue (FR/AR/EN)

---

Développé avec ❤️ pour les patients et médecins .
