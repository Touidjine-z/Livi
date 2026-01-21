# 🚀 Guide de Déploiement

## 1. Préparation avant le Déploiement

### 1.1 Vérifier le Code
```bash
# Analyser le code
flutter analyze

# Formater le code
dart format lib/

# Exécuter les tests
flutter test
```

### 1.2 Mettre à Jour les Versions

Dans `pubspec.yaml`:
```yaml
version: 1.0.0+1  # Augmenter à chaque release
```

### 1.3 Configurer Firebase

1. Créer un projet sur [Firebase Console](https://console.firebase.google.com)
2. Ajouter les configurations Firebase:
   - Android: `android/app/google-services.json`
   - iOS: `ios/Runner/GoogleService-Info.plist`

### 1.4 Configurer les Clés API

Créer un fichier `lib/secrets.dart`:
```dart
// NE PAS commiter ce fichier
const String FIREBASE_API_KEY = 'votre_cle_api';
const String GOOGLE_MAPS_API_KEY = 'votre_cle_maps';
const String EMAIL_SENDER = 'your_email@gmail.com';
const String EMAIL_PASSWORD = 'app_password';
```

## 2. Déploiement Android

### 2.1 Configuration de Base

Éditer `android/app/build.gradle`:
```gradle
android {
    compileSdkVersion 33
    
    defaultConfig {
        applicationId "com.rendezvousante.app"
        minSdkVersion 21
        targetSdkVersion 33
        versionCode 1
        versionName "1.0.0"
    }
}
```

### 2.2 Signature du APK

Créer une clé de signature:
```bash
keytool -genkey -v -keystore ~/rendez_vous_sante.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias rendez-vous-sante
```

Créer `android/key.properties`:
```properties
storePassword=your_store_password
keyPassword=your_key_password
keyAlias=rendez-vous-sante
storeFile=/path/to/rendez_vous_sante.jks
```

### 2.3 Builder l'APK Release

```bash
flutter build apk --release
```

Ou builder un Bundle pour Play Store:
```bash
flutter build appbundle --release
```

L'APK sera disponible à: `build/app/outputs/flutter-apk/app-release.apk`

### 2.4 Publier sur Google Play Store

1. Créer un compte [Google Play Console](https://play.google.com/console)
2. Créer une nouvelle application
3. Remplir les détails de l'app
4. Uploader le bundle Android
5. Ajouter des screenshots et descriptions
6. Soumettre pour révision

## 3. Déploiement iOS

### 3.1 Configuration Xcode

Ouvrir le projet dans Xcode:
```bash
open ios/Runner.xcworkspace
```

Configurer:
- Team ID
- Bundle Identifier: `com.rendezvousante.app`
- Version: `1.0.0`
- Build: `1`

### 3.2 Builder l'Archive

```bash
flutter build ios --release
```

Ou directement depuis Xcode:
1. Ouvrir `ios/Runner.xcworkspace`
2. Sélectionner "Generic iOS Device"
3. Product → Archive
4. Organizer → Distribute App

### 3.3 Publier sur App Store

1. Créer un compte [Apple Developer](https://developer.apple.com)
2. Créer l'app dans App Store Connect
3. Remplir les détails
4. Uploader l'archive
5. Soumettre pour révision

### 3.4 TestFlight

Pour tester avant la publication:
```bash
# Build pour TestFlight
flutter build ios --release

# Dans Xcode: Window → Organizer
# Sélectionner l'archive → Distribute App → TestFlight
```

## 4. Déploiement Web (Optional)

### 4.1 Builder pour le Web

```bash
flutter build web --release
```

Fichiers générés dans `build/web/`

### 4.2 Déployer sur Firebase Hosting

```bash
# Installer Firebase CLI
npm install -g firebase-tools

# Login
firebase login

# Initialize
firebase init hosting

# Deploy
firebase deploy
```

## 5. Monitoring et Analytics

### 5.1 Firebase Analytics

Ajouter dans `main.dart`:
```dart
import 'package:firebase_analytics/firebase_analytics.dart';

FirebaseAnalytics analytics = FirebaseAnalytics.instance;

// Tracker les événements
await analytics.logEvent(
  name: 'rendez_vous_reserved',
  parameters: {
    'medecin_id': medecinId,
    'date': dateTime.toString(),
  },
);
```

### 5.2 Crashlytics

Ajouter dans `pubspec.yaml`:
```yaml
firebase_crashlytics: ^3.0.0
```

Dans `main.dart`:
```dart
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

FlutterError.onError = (errorDetails) {
  FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
};

runZonedGuarded<Future<void>>(
  () async {
    runApp(const MyApp());
  },
  (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack),
);
```

## 6. Versioning et Releases

### 6.1 Semantic Versioning

Format: `MAJOR.MINOR.PATCH+BUILD`

- **MAJOR**: Changements incompatibles
- **MINOR**: Nouvelles fonctionnalités
- **PATCH**: Corrections de bugs
- **BUILD**: Numéro de build

Exemple: `1.2.3+45`

### 6.2 Changelog

Créer `CHANGELOG.md`:
```markdown
## [1.0.0] - 2024-01-21
- ✨ Lancement initial
- 📍 Localisation des médecins
- 🔐 Authentification Firebase
- 📅 Réservation de rendez-vous
```

## 7. Checklist de Déploiement

- [ ] Code revu et testé
- [ ] Pas d'erreurs d'analyse (`flutter analyze`)
- [ ] Tests unitaires passent
- [ ] Version mise à jour dans `pubspec.yaml`
- [ ] Firebase configuré
- [ ] Clés API sécurisées
- [ ] Privacy Policy à jour
- [ ] Terms of Service à jour
- [ ] Screenshots pour les stores
- [ ] Description de l'app complète
- [ ] Icônes et logos finalisés
- [ ] APK/Bundle signé
- [ ] TestFlight testé (iOS)
- [ ] Beta testé (Android)
- [ ] Documentation à jour

## 8. Post-Déploiement

### 8.1 Monitoring
- Surveiller Firebase Analytics
- Vérifier les crashlytics
- Lire les avis utilisateurs

### 8.2 Hotfixes
```bash
# Si bug urgent trouvé
flutter build apk --release  # Android
flutter build ios --release  # iOS
```

### 8.3 Communications
- Newsletter aux utilisateurs
- Posts sur réseaux sociaux
- Support utilisateurs

## 9. Ressources Utiles

- [Flutter Deploy](https://flutter.dev/docs/deployment)
- [Google Play Console Help](https://support.google.com/googleplay)
- [App Store Connect Help](https://developer.apple.com/help/app-store-connect)
- [Firebase Docs](https://firebase.google.com/docs)
- [Semantic Versioning](https://semver.org)

---

Bonne chance pour le déploiement ! 🎉
