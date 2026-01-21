# 🤝 Guide de Contribution

Merci de contribuer à **Rendez-Vous Santé ** ! 🎉

## Code de Conduite

En participant à ce projet, tu acceptes de suivre notre code de conduite basé sur le respect, l'inclusivité et la professionnalité.

## Comment Contribuer

### 1. Issues et Bugs

Si tu trouves un bug:
1. Vérifier qu'il n'existe pas déjà
2. Créer une issue avec le titre descriptif
3. Décrire les étapes pour reproduire
4. Ajouter des screenshots si pertinent
5. Mentionner ta version de Flutter/OS

### 2. Feature Requests

Pour proposer une nouvelle fonctionnalité:
1. Ouvrir une issue avec le tag `enhancement`
2. Décrire le cas d'usage
3. Expliquer pourquoi c'est utile
4. Attendre les retours avant de commencer

### 3. Pull Requests

#### Avant de commencer
```bash
# Fork et clone le repo
git clone https://github.com/YOUR_USERNAME/rendez_vous_sante.git
cd rendez_vous_sante

# Créer une branche
git checkout -b feature/ma-fonctionnalite
# ou
git checkout -b fix/mon-bug
```

#### Format de Commits
```
[TYPE] Titre court (50 caractères max)

Description détaillée (72 caractères par ligne)

Types autorisés:
- feat: Nouvelle fonctionnalité
- fix: Correction de bug
- docs: Documentation
- style: Formatage (sans changement de code)
- refactor: Refactorisation
- test: Tests
- chore: Maintenance
```

Exemples:
```
feat: Ajouter recherche de médecins par symptômes
fix: Corriger crash du scanner QR sur iOS
docs: Ajouter guide d'installation
refactor: Simplifier firebase_service.dart
```

#### Code Style
```dart
// Format avec dart format
dart format lib/

// Analyser le code
flutter analyze

// Pas d'erreurs/warnings
// Utiliser des const constructors
// Commenter le code complexe
// Max 80 caractères par ligne (documentation)
// Nommer les fichiers en snake_case
// Nommer les classes en PascalCase
// Nommer les variables en camelCase
```

#### Tests
```bash
# Exécuter les tests
flutter test

# Générer la couverture
flutter test --coverage

# Vérifier la couverture
lcov --list coverage/lcov.info
```

#### Checklist avant Push
- [ ] Code formaté (`dart format lib/`)
- [ ] Pas d'erreurs (`flutter analyze`)
- [ ] Tests passent (`flutter test`)
- [ ] Commit message clair
- [ ] Branch à jour avec `main`
- [ ] Pas de secrets/credentials

#### Soumettre une PR
1. Push vers ta branche
2. Créer une Pull Request
3. Remplir le template PR
4. Attendre la révision
5. Adresser les commentaires
6. Merger quand approuvé

### PR Template

```markdown
## Description
Brève description des changements

## Type de Changement
- [ ] Bug fix
- [ ] Nouvelle fonctionnalité
- [ ] Breaking change
- [ ] Documentation

## Testing
Description des tests effectués

## Screenshots (si applicable)
Ajouter des screenshots

## Checklist
- [ ] Code formaté
- [ ] Tests ajoutés/modifiés
- [ ] Documentation mise à jour
- [ ] Pas de warnings
- [ ] Commits squashés si nécessaire
```

## Directives de Développement

### Structure des Fichiers
```
lib/
├── nouvelles_features/
│   ├── ma_feature.dart        # Code principal
│   └── ma_feature_test.dart   # Tests
```

### Nommage
```dart
// Classes
class MedecinDetailScreen { }

// Fichiers
medecin_detail_screen.dart

// Variables
String medecinName;
int nombreAvis;

// Constantes
const int MAX_ATTEMPTS = 5;
const String APP_NAME = 'Rendez-Vous Santé';

// Fonctions privées
void _loadMedecins() { }
```

### Documentation
```dart
/// Charge la liste des médecins depuis Firebase.
/// 
/// Lance une exception si la connexion échoue.
/// 
/// Retourne une liste vide si aucun médecin trouvé.
Future<List<Medecin>> getAllMedecins() async {
  // ...
}
```

### Erreur Handling
```dart
try {
  final result = await firebaseService.getMedecins();
  setState(() => _medecins = result);
} on FirebaseException catch (e) {
  _showErrorSnackBar('Erreur Firebase: ${e.message}');
} catch (e) {
  _showErrorSnackBar('Erreur inattendue: $e');
}
```

## Processus de Révision

1. **Automatic Checks**
   - Pas d'erreurs d'analyse
   - Tests passent
   - Format correct

2. **Peer Review**
   - Minimum 1 révision
   - Vérification de la logique
   - Suggestions d'amélioration

3. **Approval**
   - Changements adressés
   - Réapprouvé si nécessaire
   - Mergé dans `main`

## Performance

- [ ] Pas de janky animations
- [ ] Pas de memory leaks
- [ ] APK size < 50MB
- [ ] Temps de démarrage < 3s

## Sécurité

- [ ] Pas de credentials en dur
- [ ] Validation des entrées
- [ ] Protection des données sensibles
- [ ] HTTPS pour API calls


---

Merci d'être un contributeur ! 🌟
