import 'package:intl/intl.dart';

class DateUtils {
  // Formater une date
  static String formatDate(DateTime date, {String format = 'dd/MM/yyyy'}) {
    return DateFormat(format).format(date);
  }

  // Formater une heure
  static String formatTime(DateTime time, {String format = 'HH:mm'}) {
    return DateFormat(format).format(time);
  }

  // Formater date et heure
  static String formatDateTime(DateTime dateTime,
      {String format = 'dd/MM/yyyy HH:mm'}) {
    return DateFormat(format).format(dateTime);
  }

  // Parser une chaîne de caractères en DateTime
  static DateTime parseDate(String dateString, {String format = 'dd/MM/yyyy'}) {
    return DateFormat(format).parse(dateString);
  }

  // Obtenir la date d'aujourd'hui
  static DateTime getToday() {
    return DateTime.now();
  }

  // Obtenir demain
  static DateTime getTomorrow() {
    return DateTime.now().add(Duration(days: 1));
  }

  // Ajouter des jours
  static DateTime addDays(DateTime date, int days) {
    return date.add(Duration(days: days));
  }

  // Soustraire des jours
  static DateTime subtractDays(DateTime date, int days) {
    return date.subtract(Duration(days: days));
  }

  // Ajouter des heures
  static DateTime addHours(DateTime dateTime, int hours) {
    return dateTime.add(Duration(hours: hours));
  }

  // Ajouter des minutes
  static DateTime addMinutes(DateTime dateTime, int minutes) {
    return dateTime.add(Duration(minutes: minutes));
  }

  // Obtenir la différence entre deux dates en jours
  static int getDaysDifference(DateTime from, DateTime to) {
    return to.difference(from).inDays;
  }

  // Véifier si une date est dans le passé
  static bool isInPast(DateTime date) {
    return date.isBefore(DateTime.now());
  }

  // Vérifier si une date est dans le futur
  static bool isInFuture(DateTime date) {
    return date.isAfter(DateTime.now());
  }

  // Vérifier si deux dates sont le même jour
  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  // Obtenir le début du jour
  static DateTime getStartOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  // Obtenir la fin du jour
  static DateTime getEndOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59);
  }

  // Générer une liste de créneaux de 15 minutes pour un jour
  static List<DateTime> generateCreneaux15Min(
      DateTime date, DateTime startTime, DateTime endTime) {
    List<DateTime> creneaux = [];
    DateTime current = DateTime(date.year, date.month, date.day,
        startTime.hour, startTime.minute);
    DateTime end = DateTime(
        date.year, date.month, date.day, endTime.hour, endTime.minute);

    while (current.isBefore(end)) {
      creneaux.add(current);
      current = current.add(Duration(minutes: 15));
    }

    return creneaux;
  }

  // Vérifier si une heure est disponible
  static bool isTimeAvailable(DateTime time, List<DateTime> occupiedTimes) {
    for (DateTime occupied in occupiedTimes) {
      if (time.hour == occupied.hour && time.minute == occupied.minute) {
        return false;
      }
    }
    return true;
  }

  // Convertir une chaîne "HH:mm-HH:mm" en heures de travail
  static Map<String, dynamic> parseWorkingHours(String workingHours) {
    List<String> parts = workingHours.split('-');
    if (parts.length != 2) return {};

    List<String> startParts = parts[0].split(':');
    List<String> endParts = parts[1].split(':');

    return {
      'startHour': int.parse(startParts[0]),
      'startMinute': int.parse(startParts[1]),
      'endHour': int.parse(endParts[0]),
      'endMinute': int.parse(endParts[1]),
    };
  }

  // Obtenir le jour de la semaine en français
  static String getDayNameFr(DateTime date) {
    const List<String> days = [
      'Lundi',
      'Mardi',
      'Mercredi',
      'Jeudi',
      'Vendredi',
      'Samedi',
      'Dimanche'
    ];
    return days[date.weekday - 1];
  }

  // Obtenir le mois en français
  static String getMonthNameFr(int month) {
    const List<String> months = [
      'Janvier',
      'Février',
      'Mars',
      'Avril',
      'Mai',
      'Juin',
      'Juillet',
      'Août',
      'Septembre',
      'Octobre',
      'Novembre',
      'Décembre'
    ];
    return months[month - 1];
  }
}
