import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interlal/app/core/services/auth_service.dart';
import 'package:interlal/app/routes/app_routes.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  final Logger _log = Logger();
  late AuthService authService;

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController resetEmailController;

  final signinFormKey = GlobalKey<FormState>();
  final signupFormKey = GlobalKey<FormState>();
  final resetPasswordFormKey = GlobalKey<FormState>();

  final errorMessage = RxnString();
  final isLoading = false.obs;
  final isPasswordObscured = true.obs;
  final isConfirmPasswordObscured = true.obs;

  @override
  void onInit() {
    super.onInit();
    authService = Get.find<AuthService>();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    resetEmailController = TextEditingController();
  }

  String? validateName(String? value) {
    final name = value?.trim() ?? '';
    if (name.isEmpty) {
      return 'O nome é obrigatório';
    }
    if (name.length < 2) {
      return 'O nome deve ter pelo menos 2 caracteres';
    }
    return null;
  }

  String? validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) {
      return 'O email é obrigatório';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      return 'Formato de email inválido';
    }
    return null;
  }

  String? validatePassword(String? value) {
    final password = value ?? '';
    if (password.isEmpty) {
      return 'A senha é obrigatória';
    }
    if (password.length < 6) {
      return 'A senha deve ter no mínimo 6 caracteres';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    final confirmPassword = value ?? '';
    if (confirmPassword.isEmpty) {
      return 'Confirme a senha';
    }
    if (confirmPassword != passwordController.text) {
      return 'As senhas não coincidem';
    }
    return null;
  }

  Future<void> signIn() async {
    _clearError();
    final isValid = signinFormKey.currentState?.validate() ?? false;
    if (!isValid) return;

    isLoading.value = true;
    try {
      await authService.signInWithEmailPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      _log.i('User signed in successfully: ${emailController.text.trim()}');
    } on AuthException catch (e) {
      _handleAuthError(e, 'Falha no login');
    } catch (e, s) {
      _handleGenericError(e, s, 'signIn');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signUp() async {
    _clearError();
    final isValid = signupFormKey.currentState?.validate() ?? false;
    if (!isValid) return;

    isLoading.value = true;

    final String name = nameController.text.trim();
    final String email = emailController.text.trim();
    final String password = passwordController.text;
    final Map<String, dynamic> userData = {'name': name};

    try {
      await authService.signUpWithEmailPassword(
        email: email,
        password: password,
        data: userData,
      );
      _log.i('User signed up successfully: ${emailController.text.trim()}');
      Get.snackbar(
        'Cadastro Iniciado',
        'Verifique seu email para confirmar a conta.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.offAllNamed(AppRoutes.signin);
      _clearFormFields();
    } on AuthException catch (e) {
      _handleAuthError(e, 'Falha no cadastro');
    } catch (e, s) {
      _handleGenericError(e, s, 'signUp');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendPasswordReset() async {
    final isValid = resetPasswordFormKey.currentState?.validate() ?? false;
    if (!isValid) return;

    isLoading.value = true;
    final email = resetEmailController.text.trim();
    try {
      await authService.sendPasswordResetEmail(email);
      _log.i('Password reset email sent to $email');
      Get.back();
      Get.snackbar(
        'Email Enviado',
        'Verifique sua caixa de entrada para redefinir a senha.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      resetEmailController.clear();
    } on AuthException catch (e) {
      _log.w('Password reset failed for $email: ${e.message}');
      Get.back();
      Get.snackbar(
        'Erro',
        _mapAuthExceptionMessage(e, 'Falha ao enviar email de redefinição'),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e, s) {
      _log.e('Unexpected error sending password reset email: $e\n$s');
      Get.back();
      Get.snackbar(
        'Erro Inesperado',
        'Ocorreu um problema. Tente novamente mais tarde.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void _handleAuthError(AuthException e, String defaultContext) {
    _log.w('$defaultContext: [${e.statusCode}] ${e.message}');
    errorMessage.value = _mapAuthExceptionMessage(e, defaultContext);
  }

  void _handleGenericError(Object e, StackTrace s, String operation) {
    _log.e('Unexpected error during $operation: $e\n$s');
    errorMessage.value = 'Ocorreu um erro inesperado. Tente novamente.';
  }

  String _mapAuthExceptionMessage(AuthException e, String defaultContext) {
    if (e.message.contains('Invalid login credentials')) {
      return 'Email ou senha inválidos.';
    }
    if (e.message.contains('User already registered')) {
      return 'Este email já está cadastrado.';
    }
    if (e.message.contains('Email rate limit exceeded')) {
      return 'Muitas tentativas. Tente novamente mais tarde.';
    }
    if (e.message.contains('Email not confirmed')) {
      return 'Confirme seu email antes de fazer login.';
    }
    _log.w('Unhandled AuthException ($defaultContext): ${e.message}');
    return 'Erro: ${e.message}';
  }

  void _clearError() {
    errorMessage.value = null;
  }

  void clearFormFieldsAndError() {
    _clearError();
    _clearFormFields();
  }

  void _clearFormFields() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    resetEmailController.clear();
  }

  void togglePasswordVisibility() {
    isPasswordObscured.value = !isPasswordObscured.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordObscured.value = !isConfirmPasswordObscured.value;
  }
}
