# 📐 Architecture du Projet

## Vue d'ensemble

L'application suit une architecture en couches bien organisée pour maintenir une séparation des préoccupations:

```
Presentation Layer (UI)
    ↓
Business Logic Layer (Services)
    ↓
Data Layer (Firebase, SQLite)
```

## 🏗️ Couches

### 1. **Presentation Layer** (UI)
Contient toutes les interfaces utilisateur et widgets.

- **Screens/** : Pages principales de l'application
  - `splash_screen.dart` : Écran de démarrage
  - `login_screen.dart` : Authentification
  - `map_screen.dart` : Affichage des médecins
  - `medecin_detail_screen.dart` : Détails du médecin
  - `reservation_screen.dart` : Réservation
  - `avis_screen.dart` : Avis des patients

- **Widgets/** : Composants réutilisables
  - `medecin_card.dart` : Carte d'affichage médecin
  - `calendrier_widget.dart` : Widget calendrier
  - `qr_code_widget.dart` : Affichage/scanner QR code

### 2. **Business Logic Layer** (Services)
Gère la logique métier et les interactions avec les données.

- **services/**
  - `firebase_service.dart` : CRUD Firebase Firestore
  - `email_service.dart` : Envoi d'emails
  - `qr_service.dart` : Génération et validation QR

- **utils/**
  - `date_utils.dart` : Manipulation des dates
  - `validation_utils.dart` : Validation des données
  - `map_utils.dart` : Géolocalisation et distances
  - `notification_utils.dart` : Notifications locales

### 3. **Data Layer** (Backend)
Gère la persistance et la récupération des données.

- **Firebase Cloud Firestore** : Base de données principale
  - Collections : medecins, patients, rendez_vous, avis
  
- **SQLite** : Stockage local pour offline-first
  
- **Firebase Storage** : Stockage des images

## 📊 Modèles de Données

```
models/
├── medecin.dart           # Médecin avec infos personnelles
├── patient.dart           # Patient avec données de profil
├── rendez_vous.dart       # Rendez-vous avec statut
└── avis.dart              # Avis et évaluations
```

## 🎯 Flux de Données

### Cas d'usage : Réservation d'un rendez-vous

```
User Action (ReservationScreen)
    ↓
FirebaseService.addRendezVous()
    ↓
Cloud Firestore (Save)
    ↓
QRService.generateQRCode()
    ↓
EmailService.sendConfirmationEmail()
    ↓
NotificationUtils.scheduleReminderNotification()
    ↓
User Confirmation Screen
```

## 🔄 Patterns Utilisés

### 1. **Service Locator Pattern**
Services centralisés et injectables

### 2. **Repository Pattern**
FirebaseService agit comme repository

### 3. **Provider Pattern** (Optional)
Pour la gestion d'état complexe

### 4. **Utility Pattern**
Classes utilitaires statiques pour les fonctions communes

## 📁 Structure des Fichiers

```
project_root/
├── lib/
│   ├── main.dart
│   ├── firebase_options.dart
│   ├── constants/
│   │   ├── colors.dart
│   │   ├── strings.dart
│   │   └── dimensions.dart
│   ├── models/
│   │   ├── medecin.dart
│   │   ├── patient.dart
│   │   ├── rendez_vous.dart
│   │   └── avis.dart
│   ├── services/
│   │   ├── firebase_service.dart
│   │   ├── email_service.dart
│   │   └── qr_service.dart
│   ├── screens/
│   │   ├── splash_screen.dart
│   │   ├── login_screen.dart
│   │   ├── map_screen.dart
│   │   ├── medecin_detail_screen.dart
│   │   ├── calendrier_screen.dart
│   │   ├── reservation_screen.dart
│   │   └── avis_screen.dart
│   ├── widgets/
│   │   ├── medecin_card.dart
│   │   ├── calendrier_widget.dart
│   │   └── qr_code_widget.dart
│   ├── utils/
│   │   ├── date_utils.dart
│   │   ├── validation_utils.dart
│   │   ├── map_utils.dart
│   │   ├── notification_utils.dart
│   │   └── mock_data.dart
│   └── constants/
│       ├── colors.dart
│       ├── strings.dart
│       └── dimensions.dart
├── android/
├── ios/
├── assets/
│   ├── images/
│   └── icons/
├── test/
├── pubspec.yaml
├── analysis_options.yaml
├── .gitignore
└── README.md
```

## 🔐 Dépendances

### Core
- `flutter` : Framework
- `firebase_core` : Initialisation Firebase
- `cloud_firestore` : Base de données
- `firebase_auth` : Authentification
- `firebase_storage` : Stockage fichiers

### UI & Navigation
- `google_maps_flutter` : Cartes
- `qr_flutter` : Génération QR
- `mobile_scanner` : Scanner QR

### State Management
- `provider` : Gestion d'état

### Utilities
- `intl` : Localisation et dates
- `geolocator` : Géolocalisation
- `flutter_local_notifications` : Notifications
- `mailer` : Envoi d'emails
- `sqflite` : Base de données locale
- `shared_preferences` : Préférences locales

## 🚀 Bonnes Pratiques

1. **Nommage**
   - Classes : PascalCase (ex: MedecinCard)
   - Fichiers : snake_case (ex: medecin_card.dart)
   - Variables : camelCase (ex: medecinName)
   - Constantes : UPPER_CASE (ex: MAX_ATTEMPTS)

2. **Documentation**
   - Commenter les fonctions complexes
   - Utiliser des docstrings pour les classes
   - Exemples d'utilisation dans les commentaires

3. **Tests**
   - Écrire des tests unitaires pour les utils
   - Tester les services avant d'intégrer
   - Tests d'intégration pour les screens

4. **Performance**
   - Minimiser les rebuilds Flutter
   - Utiliser const constructeurs
   - Lazy loading pour les images

5. **Sécurité**
   - Valider les données côté client et serveur
   - Utiliser HTTPS pour tous les appels API
   - Stocker les données sensibles de manière sécurisée

## 📈 Scalabilité

Pour améliorer la scalabilité:

1. **Ajouter des Providers**
   - Utiliser `provider` pour la gestion d'état
   - Créer des providers pour chaque service

2. **Repository Pattern Avancé**
   - Créer des repositories pour chaque entité
   - Abstractions avec interfaces

3. **Dependency Injection**
   - Utiliser `get_it` pour l'injection de dépendances
   - Faciliter les tests unitaires

4. **Modularisation**
   - Diviser en packages si le projet grandit
   - Architecture modulaire avec clean code

---

Cette architecture garantit une maintenance facile et une extension future du projet.
