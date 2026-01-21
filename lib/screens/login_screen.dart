import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';
import '../constants/dimensions.dart';
import '../utils/validation_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final isDemo = email.toLowerCase() == 'zed zed' && password.toLowerCase() == 'zed zed';

    // Si démo, on bypass la validation email stricte
    if (!isDemo && !(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      if (isDemo) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Connexion démo réussie')),
          );
          Navigator.of(context).pushReplacementNamed('/home');
        }
        return;
      }

      // Auth non configurée pour l'instant
      throw Exception('Authentification non configurée. Utilisez "zed zed" comme identifiant et mot de passe.');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: ${e.toString()}')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppDimensions.paddingLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppDimensions.paddingXLarge),
                // En-tête
                Text(
                  AppStrings.login,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                ),
                SizedBox(height: AppDimensions.paddingSmall),
                Text(
                  'Connectez-vous pour accéder à votre compte',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.grey600,
                      ),
                ),
                SizedBox(height: AppDimensions.paddingXLarge),
                // Formulaire
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Email
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: AppStrings.email,
                          prefixIcon: Icon(Icons.email_outlined, color: AppColors.primary),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: AppDimensions.padding,
                            horizontal: AppDimensions.padding,
                          ),
                        ),
                        validator: ValidationUtils.validateEmail,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: AppDimensions.padding),
                      // Mot de passe
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          hintText: AppStrings.password,
                          prefixIcon: Icon(Icons.lock_outlined, color: AppColors.primary),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword ? Icons.visibility_off : Icons.visibility,
                              color: AppColors.primary,
                            ),
                            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: AppDimensions.padding,
                            horizontal: AppDimensions.padding,
                          ),
                        ),
                        validator: ValidationUtils.validatePassword,
                      ),
                      SizedBox(height: AppDimensions.paddingSmall),
                      // Mot de passe oublié
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // TODO: Implémenter la récupération de mot de passe
                          },
                          child: Text(
                            AppStrings.forgotPassword,
                            style: TextStyle(color: AppColors.primary),
                          ),
                        ),
                      ),
                      SizedBox(height: AppDimensions.paddingLarge),
                      // Bouton de connexion
                      SizedBox(
                        width: double.infinity,
                        height: AppDimensions.buttonHeight,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
                            ),
                          ),
                          child: _isLoading
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : Text(
                                  AppStrings.connexion,
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
                SizedBox(height: AppDimensions.paddingXLarge),
                // Inscription
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.dontHaveAccount,
                        style: TextStyle(color: AppColors.grey600),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/signup');
                        },
                        child: Text(
                          AppStrings.signup,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
