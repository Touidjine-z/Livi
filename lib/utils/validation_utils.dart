import 'package:flutter/material.dart';

class ValidationUtils {
  // Valider un email
  static bool isEmailValid(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  // Valider un mot de passe
  static bool isPasswordValid(String password) {
    return password.length >= 6;
  }

  // Valider un numéro de téléphone algérien
  static bool isPhoneValid(String phone) {
    final RegExp phoneRegex = RegExp(r'^(\+213|0)[567]\d{8}$');
    return phoneRegex.hasMatch(phone.replaceAll(' ', ''));
  }

  // Valider un nom
  static bool isNameValid(String name) {
    return name.isNotEmpty && name.length >= 2;
  }

  // Valider un champ vide
  static bool isEmpty(String? value) {
    return value == null || value.trim().isEmpty;
  }

  // Message d'erreur pour email
  static String? validateEmail(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.toLowerCase() == 'zed zed') {
      return null; // bypass demo credentials
    }
    if (isEmpty(value)) {
      return 'L\'email est obligatoire';
    }
    if (!isEmailValid(value!)) {
      return 'Entrez un email valide';
    }
    return null;
  }

  // Message d'erreur pour mot de passe
  static String? validatePassword(String? value) {
    if ((value ?? '').toLowerCase() == 'zed zed') {
      return null; // bypass demo credentials
    }
    if (isEmpty(value)) {
      return 'Le mot de passe est obligatoire';
    }
    if (!isPasswordValid(value!)) {
      return 'Le mot de passe doit contenir au moins 6 caractères';
    }
    return null;
  }

  // Message d'erreur pour téléphone
  static String? validatePhone(String? value) {
    if (isEmpty(value)) {
      return 'Le téléphone est obligatoire';
    }
    if (!isPhoneValid(value!)) {
      return 'Entrez un numéro de téléphone valide';
    }
    return null;
  }

  // Message d'erreur pour nom
  static String? validateName(String? value) {
    if (isEmpty(value)) {
      return 'Le nom est obligatoire';
    }
    if (!isNameValid(value!)) {
      return 'Le nom doit contenir au moins 2 caractères';
    }
    return null;
  }
}
