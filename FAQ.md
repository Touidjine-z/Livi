# ❓ FAQ - Questions Fréquemment Posées

## Installation et Configuration

### Q: Qu'est-ce que je dois installer d'abord?
**A:** Installe Flutter 3.0+ depuis https://flutter.dev/docs/get-started/install

### Q: Comment configurer Firebase?
**A:** 
1. Créer un projet sur https://console.firebase.google.com
2. Télécharger google-services.json (Android) et GoogleService-Info.plist (iOS)
3. Placer les fichiers dans les répertoires appropriés
4. Mettre à jour lib/firebase_options.dart

### Q: Où ajouter mes clés API Google Maps?
**A:**
- **Android**: android/app/build.gradle
- **iOS**: ios/Runner/Info.plist
- Ou utiliser Flutter Platform Channels

### Q: Comment installer les dépendances?
**A:**
```bash
cd rendez_vous_sante
flutter pub get
```

## Développement

### Q: Comment lancer l'app en développement?
**A:**
```bash
flutter run
# ou depuis VS Code/Android Studio
# F5 ou Shift+F5
```

### Q: Pourquoi j'obtiens l'erreur "MissingPluginException"?
**A:** 
```bash
flutter clean
flutter pub get
flutter run
```

### Q: Comment déboguer l'app?
**A:**
- VS Code: F5 pour attacher le debuggeur
- Android Studio: Run → Debug
- DevTools: `flutter pub global activate devtools` puis `devtools`

### Q: Comment tester localement?
**A:**
```bash
flutter test              # Tests unitaires
flutter test -v           # Avec output verbose
flutter test --coverage   # Couverture de code
```

### Q: Qu'est-ce qu'un "rebuild"?
**A:** C'est quand Flutter recompile et met à jour l'app sur ton appareil après une modification du code. Utilise `r` pour rebuild ou `R` pour hot restart.

## Fonctionnalités

### Q: Comment ajouter un nouveau écran?
**A:**
1. Créer un fichier dans lib/screens/mon_ecran.dart
2. Créer une classe qui étend StatefulWidget ou StatelessWidget
3. Ajouter la route dans main.dart
4. Naviguer avec Navigator.of(context).pushNamed()

### Q: Comment connecter Firebase Firestore?
**A:**
```dart
// Dans firebase_service.dart
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Lire
DocumentSnapshot doc = await _firestore.collection('medecins').doc(id).get();

// Écrire
await _firestore.collection('medecins').add(data);

// Supprimer
await _firestore.collection('medecins').doc(id).delete();
```

### Q: Comment générer un QR code?
**A:**
```dart
import 'package:qr_flutter/qr_flutter.dart';

QrImage(
  data: 'RV:rendez_vous_id',
  size: 200,
)
```

### Q: Comment envoyer un email?
**A:**
Voir lib/services/email_service.dart
```dart
EmailService.sendConfirmationEmail(
  recipientEmail: 'patient@example.com',
  medecinName: 'Dr. Ahmed',
  // ...
);
```

### Q: Comment ajouter des notifications?
**A:**
```dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Initialiser dans main.dart
await NotificationUtils.initNotifications();

// Afficher une notification
NotificationUtils.showNotification(
  id: 1,
  title: 'Titre',
  body: 'Contenu',
);
```

## Problèmes Courants

### Q: "The method '-[FlutterViewController flutterTextInputDelegate]' was not found"
**A:** Mise à jour iOS Pod
```bash
cd ios
rm -rf Pods
pod install
cd ..
flutter run
```

### Q: "Gradle failed with error code 1"
**A:**
```bash
flutter clean
flutter pub get
flutter pub upgrade
flutter run
```

### Q: Google Maps ne s'affiche pas
**A:**
- Vérifier la clé API
- Android: vérifier android/app/src/main/AndroidManifest.xml
- iOS: vérifier ios/Runner/Info.plist

### Q: Le scanner QR ne fonctionne pas
**A:**
- Vérifier les permissions d'appareil photo
- Android: vérifier permissions dans AndroidManifest.xml
- iOS: vérifier Info.plist

### Q: Problèmes de connexion à Firebase
**A:**
```bash
# Vérifier la configuration
firebase list

# Vérifier internet
adb shell netstat | grep -i connected

# Réinitialiser
flutter clean && flutter pub get
```

## Performance

### Q: Pourquoi l'app est lente?
**A:** 
- Vérifier flutter analyze
- Utiliser DevTools pour profiler
- Éviter les rebuilds inutiles
- Lazy load les images
- Limiter les appels API

### Q: Comment optimiser la taille de l'APK?
**A:**
```bash
# Build optimisé
flutter build apk --release

# Analyser la taille
flutter build apk --target-platform android-arm64 --release

# Réduire les assets
# Compresser les images
# Utiliser le tree-shaking
```

### Q: Comment améliorer le temps de démarrage?
**A:**
- Lazy load les écrans
- Initialiser Firebase de manière asynchrone
- Minimiser les opérations au démarrage
- Utiliser const constructors

## Tests

### Q: Comment écrire un test unitaire?
**A:**
```dart
test('validateEmail should return null for valid email', () {
  String? result = ValidationUtils.validateEmail('test@example.com');
  expect(result, isNull);
});
```

### Q: Comment mocker Firebase?
**A:**
```dart
// Utiliser fake_cloud_firestore
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

final firestore = FakeFirebaseFirestore();
```

### Q: Comment tester un Widget?
**A:**
```dart
testWidgets('MedecinCard displays medecin name', (WidgetTester tester) async {
  await tester.pumpWidget(MaterialApp(
    home: MedecinCard(medecin: mockMedecin, onTap: () {}),
  ));
  
  expect(find.text('Dr. Ahmed'), findsOneWidget);
});
```

## Déploiement

### Q: Comment préparer pour la production?
**A:**
1. Mettre à jour la version dans pubspec.yaml
2. Exécuter `flutter analyze` et `flutter test`
3. Configurer Firebase pour production
4. Signer l'APK (Android) ou Archive (iOS)

### Q: Comment créer une clé de signature Android?
**A:**
```bash
keytool -genkey -v -keystore rendez_vous_sante.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias rendez-vous-sante
```

### Q: Comment faire une beta release?
**A:**
- Android: Google Play Console → Testing → Beta
- iOS: App Store Connect → TestFlight

### Q: Quel est le processus de révision?
**A:**
- **Android Play Store**: 1-3 jours
- **Apple App Store**: 24-48 heures
- Ajouter une description claire et des screenshots

## Sécurité

### Q: Où stocker les données sensibles?
**A:**
```dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const secureStorage = FlutterSecureStorage();
await secureStorage.write(key: 'password', value: password);
```

### Q: Comment protéger les clés API?
**A:**
- Ne pas les commiter sur GitHub
- Utiliser des fichiers .env
- Utiliser des variables d'environnement
- Utiliser Cloud Functions pour les appels sensibles

## Internationalisation

### Q: Comment ajouter le français et l'arabe?
**A:**
```yaml
# pubspec.yaml
dependencies:
  intl: ^0.19.0

# Créer lib/l10n/app_fr.arb et app_ar.arb
```

### Q: Comment changer la langue?
**A:**
Voir lib/constants/strings.dart
Implémenter un changement de localisation avec intl ou get_it

## Bases de Données

### Q: Comment utiliser SQLite localement?
**A:**
```dart
import 'package:sqflite/sqflite.dart';

// Ouvrir la base
Database db = await openDatabase('rendez_vous_sante.db');

// CRUD operations
await db.insert('medecins', medecin.toJson());
```

### Q: Comment synchroniser SQLite avec Firebase?
**A:**
- Implémenter une queue de synchronisation
- Tagguer les entrées avec timestamp
- Sync quand internet est disponible

## Ressources

### Documentation
- Flutter: https://flutter.dev/docs
- Firebase: https://firebase.google.com/docs
- Material Design: https://m3.material.io
- Dart: https://dart.dev/guides

### Tutorials
- YouTube: Flutter Official Channel
- Medium: Flutter Articles
- YouTube: Traversy Media, The Net Ninja

### Tools
- VS Code: Flutter extension
- Android Studio: Flutter plugin
- DevTools: `flutter pub global activate devtools`
- Firebase CLI: `npm install -g firebase-tools`

## Comment Obtenir du Support

- 📧 **Email**: support@rendezvousante.dz
- 💬 **Discord**: discord.gg/rendezvousante
- 🐛 **Issues**: github.com/rendezvousante/issues
- 📚 **Wiki**: github.com/rendezvousante/wiki

---

**Last Updated**: 21 janvier 2026

Vous n'avez pas trouvé la réponse? Ouvrez une issue! 🚀
