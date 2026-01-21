import 'package:flutter/material.dart';
import '../models/medecin.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';

class MedecinCard extends StatelessWidget {
  final Medecin medecin;
  final VoidCallback onTap;
  final double? distance;

  const MedecinCard({
    Key? key,
    required this.medecin,
    required this.onTap,
    this.distance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(AppDimensions.paddingSmall),
      elevation: AppDimensions.elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // En-tête avec nom et spécialité
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.primaryLight,
                    child: Text(
                      medecin.nom[0],
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  SizedBox(width: AppDimensions.padding),
                  // Infos
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          medecin.nom,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          medecin.specialite,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.grey600,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppDimensions.padding),
              // Avis et tarif
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Étoiles d'avis
                  Row(
                    children: [
                      ...List.generate(5, (index) {
                        return Icon(
                          index < medecin.avisMoyen.toInt()
                              ? Icons.star
                              : Icons.star_border,
                          color: AppColors.warning,
                          size: AppDimensions.iconSmall,
                        );
                      }),
                      SizedBox(width: 4),
                      Text(
                        '(${medecin.nombreAvis})',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.grey600,
                            ),
                      ),
                    ],
                  ),
                  // Tarif
                  Text(
                    '${medecin.tarif.toStringAsFixed(0)} DA',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                  ),
                ],
              ),
              SizedBox(height: AppDimensions.paddingSmall),
              // Distance (si disponible)
              if (distance != null)
                Text(
                  '${distance!.toStringAsFixed(1)} km',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.success,
                      ),
                ),
              SizedBox(height: AppDimensions.paddingSmall),
              // Prestations
              SizedBox(
                height: 24,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: medecin.prestations.length,
                  separatorBuilder: (_, __) => SizedBox(width: 4),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimensions.paddingSmall,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryLight,
                        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall),
                      ),
                      child: Text(
                        medecin.prestations[index],
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.secondary,
                              fontSize: 10,
                            ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
