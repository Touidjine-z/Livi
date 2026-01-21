import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';
import '../constants/dimensions.dart';
import '../models/medecin.dart';
import '../widgets/medecin_card.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _searchController = TextEditingController();
  String? _selectedRegion;
  List<Medecin> _medecins = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMedecins();
  }

  Future<void> _loadMedecins() async {
    // TODO: Charger les médecins depuis Firebase
    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.carte),
        backgroundColor: AppColors.primary,
      ),
      body: Column(
        children: [
          // Recherche et filtres
          Padding(
            padding: EdgeInsets.all(AppDimensions.padding),
            child: Column(
              children: [
                // Champ de recherche
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: AppStrings.recherche,
                    prefixIcon: Icon(Icons.search, color: AppColors.primary),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: AppDimensions.padding,
                      horizontal: AppDimensions.padding,
                    ),
                  ),
                  onChanged: (value) => setState(() {}),
                ),
                SizedBox(height: AppDimensions.padding),
                // Filtre par région
                DropdownButtonFormField<String>(
                  value: _selectedRegion,
                  hint: Text(AppStrings.rechercherParRegion),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.location_on, color: AppColors.primary),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: AppDimensions.padding,
                      horizontal: AppDimensions.padding,
                    ),
                  ),
                  items: [
                    'Alger',
                    'Oran',
                    'Constantine',
                    'Annaba',
                    'Blida',
                  ]
                      .map((region) => DropdownMenuItem(
                            value: region,
                            child: Text(region),
                          ))
                      .toList(),
                  onChanged: (value) => setState(() => _selectedRegion = value),
                ),
              ],
            ),
          ),
          // Liste des médecins
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _medecins.isEmpty
                    ? Center(
                        child: Text(
                          AppStrings.vide,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      )
                    : ListView.builder(
                        itemCount: _medecins.length,
                        itemBuilder: (context, index) {
                          Medecin medecin = _medecins[index];
                          return MedecinCard(
                            medecin: medecin,
                            onTap: () {
                              Navigator.of(context).pushNamed('/medecin_detail', arguments: medecin);
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
