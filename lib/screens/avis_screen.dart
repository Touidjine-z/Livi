import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';
import '../constants/dimensions.dart';
import '../models/medecin.dart';

class AvisScreen extends StatefulWidget {
  final RendezVous? rendezVous;
  final Medecin medecin;

  const AvisScreen({
    Key? key,
    this.rendezVous,
    required this.medecin,
  }) : super(key: key);

  @override
  State<AvisScreen> createState() => _AvisScreenState();
}

class _AvisScreenState extends State<AvisScreen> {
  int _rating = 5;
  final _commentController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _submitReview() async {
    if (_commentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez ajouter un commentaire')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      // TODO: Envoyer l'avis à Firebase
      print('Rating: $_rating');
      print('Comment: ${_commentController.text}');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Avis soumis avec succès'),
          backgroundColor: AppColors.success,
        ),
      );

      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: ${e.toString()}')),
      );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.avis),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.paddingLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // En-tête
              Card(
                child: Padding(
                  padding: EdgeInsets.all(AppDimensions.padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Donnez votre avis',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Dr. ${widget.medecin.nom}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.grey600,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: AppDimensions.paddingXLarge),
              // Sélection de la note
              Center(
                child: Column(
                  children: [
                    Text(
                      'Comment évaluez-vous votre expérience?',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(height: AppDimensions.paddingLarge),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return GestureDetector(
                          onTap: () => setState(() => _rating = index + 1),
                          child: Icon(
                            index < _rating ? Icons.star : Icons.star_border,
                            color: AppColors.warning,
                            size: 40,
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: AppDimensions.paddingLarge),
                    Text(
                      _rating == 1
                          ? 'Très insatisfait'
                          : _rating == 2
                              ? 'Insatisfait'
                              : _rating == 3
                                  ? 'Neutre'
                                  : _rating == 4
                                      ? 'Satisfait'
                                      : 'Très satisfait',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppDimensions.paddingXLarge),
              // Commentaire
              Text(
                'Votre commentaire',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: AppDimensions.paddingSmall),
              TextFormField(
                controller: _commentController,
                maxLines: 5,
                minLines: 3,
                decoration: InputDecoration(
                  hintText: 'Partagez votre expérience avec le médecin...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
                  ),
                  contentPadding: EdgeInsets.all(AppDimensions.padding),
                ),
              ),
              SizedBox(height: AppDimensions.paddingXLarge),
              // Boutons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.close),
                      label: Text(AppStrings.annulerBouton),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.grey400,
                      ),
                    ),
                  ),
                  SizedBox(width: AppDimensions.padding),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isSubmitting ? null : _submitReview,
                      icon: Icon(Icons.send),
                      label: Text(AppStrings.envoyer),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// TODO: Importer la classe RendezVous depuis models
class RendezVous {}
