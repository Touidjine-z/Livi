import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailService {
  // Configuration SMTP (à configurer avec tes paramètres réels)
  static const String senderEmail = 'your-email@gmail.com';
  static const String senderPassword = 'your-app-password'; // Utiliser un mot de passe d'application

  // Envoyer un email de confirmation de rendez-vous
  static Future<void> sendConfirmationEmail({
    required String recipientEmail,
    required String patientName,
    required String medecinName,
    required String dateHeure,
    required String? qrCode,
  }) async {
    try {
      final smtpServer = gmail(senderEmail, senderPassword);

      final message = Message()
        ..from = Address(senderEmail, 'Rendez-Vous Santé Algérie')
        ..recipients.add(recipientEmail)
        ..subject = 'Confirmation de votre rendez-vous'
        ..html = '''
          <html>
            <body style="font-family: Arial, sans-serif;">
              <h2>Confirmation de rendez-vous</h2>
              <p>Bonjour $patientName,</p>
              <p>Votre rendez-vous avec Dr. $medecinName a été confirmé pour le:</p>
              <p><strong>$dateHeure</strong></p>
              <p>Veuillez présenter le code QR ci-dessous lors de votre visite:</p>
              <p><strong>$qrCode</strong></p>
              <p>Cordialement,</p>
              <p>L'équipe Rendez-Vous Santé</p>
            </body>
          </html>
        ''';

      await send(message, smtpServer);
      print('Email envoyé avec succès');
    } catch (e) {
      print('Erreur lors de l\'envoi de l\'email: $e');
      throw Exception('Erreur lors de l\'envoi de l\'email: $e');
    }
  }

  // Envoyer un email d'annulation
  static Future<void> sendCancellationEmail({
    required String recipientEmail,
    required String patientName,
    required String medecinName,
    required String dateHeure,
  }) async {
    try {
      final smtpServer = gmail(senderEmail, senderPassword);

      final message = Message()
        ..from = Address(senderEmail, 'Rendez-Vous Santé Algérie')
        ..recipients.add(recipientEmail)
        ..subject = 'Annulation de votre rendez-vous'
        ..html = '''
          <html>
            <body style="font-family: Arial, sans-serif;">
              <h2>Annulation de rendez-vous</h2>
              <p>Bonjour $patientName,</p>
              <p>Votre rendez-vous avec Dr. $medecinName du <strong>$dateHeure</strong> a été annulé.</p>
              <p>Si vous avez besoin de prendre un nouveau rendez-vous, veuillez accéder à notre application.</p>
              <p>Cordialement,</p>
              <p>L'équipe Rendez-Vous Santé</p>
            </body>
          </html>
        ''';

      await send(message, smtpServer);
      print('Email d\'annulation envoyé avec succès');
    } catch (e) {
      print('Erreur lors de l\'envoi de l\'email: $e');
      throw Exception('Erreur lors de l\'envoi de l\'email: $e');
    }
  }

  // Envoyer un email de rappel
  static Future<void> sendReminderEmail({
    required String recipientEmail,
    required String patientName,
    required String medecinName,
    required String dateHeure,
  }) async {
    try {
      final smtpServer = gmail(senderEmail, senderPassword);

      final message = Message()
        ..from = Address(senderEmail, 'Rendez-Vous Santé Algérie')
        ..recipients.add(recipientEmail)
        ..subject = 'Rappel: Votre rendez-vous approche'
        ..html = '''
          <html>
            <body style="font-family: Arial, sans-serif;">
              <h2>Rappel de rendez-vous</h2>
              <p>Bonjour $patientName,</p>
              <p>Ceci est un rappel que votre rendez-vous avec Dr. $medecinName approche:</p>
              <p><strong>$dateHeure</strong></p>
              <p>Merci de vous présenter 10 minutes avant l'heure prévue.</p>
              <p>Cordialement,</p>
              <p>L'équipe Rendez-Vous Santé</p>
            </body>
          </html>
        ''';

      await send(message, smtpServer);
      print('Email de rappel envoyé avec succès');
    } catch (e) {
      print('Erreur lors de l\'envoi de l\'email: $e');
      throw Exception('Erreur lors de l\'envoi de l\'email: $e');
    }
  }

  // Envoyer un email de contact
  static Future<void> sendContactEmail({
    required String senderName,
    required String senderEmailAddress,
    required String subject,
    required String message,
  }) async {
    try {
      final smtpServer = gmail(senderEmail, senderPassword);

      final email = Message()
        ..from = Address(senderEmail, 'Rendez-Vous Santé Algérie')
        ..recipients.add('contact@rendezvousante.dz')
        ..subject = subject
        ..html = '''
          <html>
            <body style="font-family: Arial, sans-serif;">
              <h2>Nouveau message de contact</h2>
              <p><strong>De:</strong> $senderName ($senderEmailAddress)</p>
              <p><strong>Sujet:</strong> $subject</p>
              <p><strong>Message:</strong></p>
              <p>$message</p>
            </body>
          </html>
        ''';

      await send(email, smtpServer);
      print('Email de contact envoyé avec succès');
    } catch (e) {
      print('Erreur lors de l\'envoi de l\'email: $e');
      throw Exception('Erreur lors de l\'envoi de l\'email: $e');
    }
  }
}
