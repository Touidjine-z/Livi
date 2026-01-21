import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';
import '../constants/dimensions.dart';
import '../models/medecin.dart';
import '../widgets/calendrier_widget.dart';

class MedecinDetailScreen extends StatefulWidget {
  final Medecin medecin;

  const MedecinDetailScreen({
    Key? key,
    required this.medecin,
  }) : super(key: key);

  @override
  State<MedecinDetailScreen> createState() => _MedecinDetailScreenState();
}

class _MedecinDetailScreenState extends State<MedecinDetailScreen> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dr. ${widget.medecin.nom}'),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // En-tête avec photo et info
            Container(
              color: AppColors.primaryLight,
              padding: EdgeInsets.all(AppDimensions.paddingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.primary,
                    child: Text(
                      widget.medecin.nom[0],
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: AppDimensions.paddingLarge),
                  // Nom et spécialité
                  Text(
                    'Dr. ${widget.medecin.nom}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    widget.medecin.specialite,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.grey600,
                        ),
                  ),
                  SizedBox(height: AppDimensions.paddingLarge),
                  // Avis et tarif
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Avis
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ...List.generate(5, (index) {
                                return Icon(
                                  index < widget.medecin.avisMoyen.toInt()
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: AppColors.warning,
                                );
                              }),
                            ],
                          ),
                          Text(
                            '${widget.medecin.avisMoyen}/5 (${widget.medecin.nombreAvis} avis)',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      // Tarif
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            AppStrings.tarif,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.grey600,
                                ),
                          ),
                          Text(
                            '${widget.medecin.tarif.toStringAsFixed(0)} DA',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Contenu
            Padding(
              padding: EdgeInsets.all(AppDimensions.paddingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Contact et adresse
                  if (widget.medecin.telephone != null) ...[
                    _buildInfoSection(
                      icon: Icons.phone,
                      title: AppStrings.telephone,
                      content: widget.medecin.telephone!,
                    ),
                    SizedBox(height: AppDimensions.padding),
                  ],
                  if (widget.medecin.adresse != null) ...[
                    _buildInfoSection(
                      icon: Icons.location_on,
                      title: AppStrings.adresse,
                      content: widget.medecin.adresse!,
                    ),
                    SizedBox(height: AppDimensions.padding),
                  ],
                  // Prestations
                  Text(
                    AppStrings.prestations,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(height: AppDimensions.paddingSmall),
                  Wrap(
                    spacing: AppDimensions.paddingSmall,
                    children: widget.medecin.prestations
                        .map((prestation) => Chip(
                              label: Text(prestation),
                              backgroundColor: AppColors.secondaryLight,
                            ))
                        .toList(),
                  ),
                  SizedBox(height: AppDimensions.paddingXLarge),
                  // Calendrier
                  Text(
                    AppStrings.calendrier,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(height: AppDimensions.paddingLarge),
                  CalendrierWidget(
                    onDateSelected: (date) {
                      setState(() => _selectedDate = date);
                    },
                  ),
                  SizedBox(height: AppDimensions.paddingXLarge),
                  // Bouton de réservation
                  SizedBox(
                    width: double.infinity,
                    height: AppDimensions.buttonHeight,
                    child: ElevatedButton(
                      onPressed: _selectedDate != null
                          ? () {
                              Navigator.of(context).pushNamed(
                                '/reservation',
                                arguments: {
                                  'medecin': widget.medecin,
                                  'date': _selectedDate,
                                },
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppDimensions.borderRadiusLarge),
                        ),
                      ),
                      child: Text(
                        AppStrings.reserver,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.primary, size: AppDimensions.iconLarge),
        SizedBox(width: AppDimensions.padding),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.grey600,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 4),
              Text(
                content,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
