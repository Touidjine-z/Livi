import 'package:qr_flutter/qr_flutter.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRService {
  // Générer un code QR pour un rendez-vous
  static String generateQRCode(String rendezVousId) {
    // Format: rendez_vous_id_patient_id_medecin_id_timestamp
    return 'RV:$rendezVousId:${DateTime.now().millisecondsSinceEpoch}';
  }

  // Parser les données d'un code QR
  static Map<String, String>? parseQRCode(String qrData) {
    try {
      List<String> parts = qrData.split(':');
      if (parts.length >= 2 && parts[0] == 'RV') {
        return {
          'type': parts[0],
          'rendezVousId': parts[1],
          'timestamp': parts.length > 2 ? parts[2] : '',
        };
      }
      return null;
    } catch (e) {
      print('Erreur lors du parsing du QR code: $e');
      return null;
    }
  }

  // Valider un code QR de rendez-vous
  static bool validateQRCode(String qrData) {
    Map<String, String>? parsed = parseQRCode(qrData);
    return parsed != null && parsed['type'] == 'RV';
  }

  // Obtenir l'ID du rendez-vous à partir du code QR
  static String? getRendezVousIdFromQR(String qrData) {
    Map<String, String>? parsed = parseQRCode(qrData);
    return parsed?['rendezVousId'];
  }
}
