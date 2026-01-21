import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';
import '../constants/dimensions.dart';
import '../models/medecin.dart';
import '../models/rendez_vous.dart';
import '../services/qr_service.dart';
import '../widgets/qr_code_widget.dart';

class ReservationScreen extends StatefulWidget {
  final Medecin medecin;
  final DateTime selectedDate;

  const ReservationScreen({
    Key? key,
    required this.medecin,
    required this.selectedDate,
  }) : super(key: key);

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  String? _selectedTime;
  String? _notes;
  bool _isConfirming = false;
  bool _isConfirmed = false;
  String? _qrCode;

  List<String> _timeSlots = [
    '09:00',
    '09:15',
    '09:30',
    '09:45',
    '10:00',
    '10:15',
    '10:30',
    '10:45',
    '11:00',
    '14:00',
    '14:15',
    '14:30',
    '14:45',
    '15:00',
    '15:15',
    '15:30',
    '15:45',
    '16:00',
  ];

  void _confirmReservation() async {
    if (_selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez sélectionner une heure')),
      );
      return;
    }

    setState(() => _isConfirming = true);

    try {
      // TODO: Créer le rendez-vous dans Firebase
      String qrCode = QRService.generateQRCode('rv_${DateTime.now().millisecondsSinceEpoch}');
      
      setState(() {
        _isConfirmed = true;
        _qrCode = qrCode;
      });

      // TODO: Envoyer un email de confirmation
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: ${e.toString()}')),
      );
    } finally {
      if (mounted) setState(() => _isConfirming = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isConfirmed && _qrCode != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.rendezVousConfirme),
          backgroundColor: AppColors.success,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppDimensions.paddingLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: AppDimensions.paddingLarge),
                // Icône de succès
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.success,
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                SizedBox(height: AppDimensions.paddingLarge),
                // Message de confirmation
                Text(
                  'Rendez-vous confirmé',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.success,
                      ),
                ),
                SizedBox(height: AppDimensions.paddingLarge),
                // Détails du RDV
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(AppDimensions.padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow('Médecin', 'Dr. ${widget.medecin.nom}'),
                        Divider(),
                        _buildDetailRow(
                          'Date',
                          '${widget.selectedDate.day}/${widget.selectedDate.month}/${widget.selectedDate.year}',
                        ),
                        Divider(),
                        _buildDetailRow('Heure', _selectedTime ?? ''),
                        Divider(),
                        _buildDetailRow('Tarif', '${widget.medecin.tarif.toStringAsFixed(0)} DA'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: AppDimensions.paddingLarge),
                // QR Code
                QRCodeWidget(
                  qrData: _qrCode!,
                  title: 'Code QR du rendez-vous',
                ),
                SizedBox(height: AppDimensions.paddingXLarge),
                // Boutons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).popUntil(
                            (route) => route.isFirst,
                          );
                        },
                        icon: Icon(Icons.home),
                        label: Text('Accueil'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                        ),
                      ),
                    ),
                    SizedBox(width: AppDimensions.padding),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // TODO: Télécharger ou partager le QR code
                        },
                        icon: Icon(Icons.download),
                        label: Text('Télécharger'),
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

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.reservation),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.paddingLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Infos du médecin
              Card(
                child: Padding(
                  padding: EdgeInsets.all(AppDimensions.padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dr. ${widget.medecin.nom}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        widget.medecin.specialite,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.grey600,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: AppDimensions.paddingLarge),
              // Date
              Text(
                'Date: ${widget.selectedDate.day}/${widget.selectedDate.month}/${widget.selectedDate.year}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: AppDimensions.paddingLarge),
              // Sélection de l'heure
              Text(
                AppStrings.selectionnezCreneaux,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: AppDimensions.paddingLarge),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2,
                  mainAxisSpacing: AppDimensions.padding,
                  crossAxisSpacing: AppDimensions.padding,
                ),
                itemCount: _timeSlots.length,
                itemBuilder: (context, index) {
                  String time = _timeSlots[index];
                  bool isSelected = _selectedTime == time;
                  return InkWell(
                    onTap: () => setState(() => _selectedTime = time),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected ? AppColors.primary : AppColors.grey300,
                          width: 2,
                        ),
                        borderRadius:
                            BorderRadius.circular(AppDimensions.borderRadiusLarge),
                        color: isSelected ? AppColors.primaryLight : Colors.transparent,
                      ),
                      child: Center(
                        child: Text(
                          time,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                color: isSelected ? AppColors.primary : AppColors.onBackground,
                              ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: AppDimensions.paddingLarge),
              // Notes optionnelles
              TextFormField(
                onChanged: (value) => _notes = value,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Notes optionnelles (allergie, préoccupations...)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
                  ),
                  contentPadding: EdgeInsets.all(AppDimensions.padding),
                ),
              ),
              SizedBox(height: AppDimensions.paddingXLarge),
              // Résumé du coût
              Container(
                padding: EdgeInsets.all(AppDimensions.padding),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tarif',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.grey600,
                          ),
                    ),
                    Text(
                      '${widget.medecin.tarif.toStringAsFixed(0)} DA',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppDimensions.paddingXLarge),
              // Bouton de confirmation
              SizedBox(
                width: double.infinity,
                height: AppDimensions.buttonHeight,
                child: ElevatedButton(
                  onPressed: _isConfirming ? null : _confirmReservation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
                    ),
                  ),
                  child: _isConfirming
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(
                          AppStrings.confirmer,
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
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppDimensions.paddingSmall),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.grey600,
                ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
