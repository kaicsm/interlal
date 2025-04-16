import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:interlal/app/routes/app_routes.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService extends GetxService {
  final Logger _log = Logger();
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  final Rx<User?> _currentUser = Rx<User?>(null);
  User? get currentUser => _currentUser.value;

  Stream<AuthState> get authStateChanges =>
      _supabaseClient.auth.onAuthStateChange;

  @override
  void onInit() {
    super.onInit();
    _currentUser.value = _supabaseClient.auth.currentUser;
    authStateChanges.listen((AuthState state) {
      _log.i("Auth state change event: ${state.event}");
      _currentUser.value = state.session?.user;

      Future.microtask(() async {
        final currentRoute = Get.currentRoute;

        if (state.event == AuthChangeEvent.signedIn &&
            currentRoute != AppRoutes.shell) {
          _log.i("Redirecting to shell");
          Get.offAllNamed(AppRoutes.shell);
        } else if (state.event == AuthChangeEvent.signedOut &&
            currentRoute != AppRoutes.signin) {
          _log.i("Redirecting to login");
          Get.offAllNamed(AppRoutes.signin);
        } else {
          _log.i("No redirection needed for event ${state.event}");
        }
      });
    });

    _log.i(
      "AuthService initialized. Current user: ${_currentUser.value?.email ?? 'none'}",
    );
  }

  Future<AuthResponse> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      _log.i("User signed in");
      return response;
    } on AuthException catch (e) {
      _log.e("Error signing in: ${e.message}");
      rethrow;
    } catch (e, s) {
      _log.e("Unexpected error signing in: $e, $s");
      rethrow;
    }
  }

  Future<AuthResponse> signUpWithEmailPassword({
    required String email,
    required String password,
    Map<String, dynamic>? data,
  }) async {
    try {
      _log.i("Signing up user with email: $email");
      final response = await _supabaseClient.auth.signUp(
        email: email.trim(),
        password: password,
        data: data, // Passa dados adicionais para o perfil Supabase
      );

      // Verifica se o usuário foi criado com sucesso
      if (response.user != null && response.session == null) {
        _log.i("User started to ${response.user?.email}");
      } else if (response.user != null && response.session != null) {
        _log.i("User signed in after creation");
      } else {
        _log.w("SignUp not result in a user or session. Response: $response");
      }

      return response;
    } on AuthException catch (e) {
      _log.w("SignUp failed: $e");
      rethrow;
    } catch (e, s) {
      _log.e("Unexpected error signing up: $e, $s");
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _supabaseClient.auth.signOut();
      _log.i("User signed out");
    } catch (e, s) {
      _log.e("Unexpected error signing out: $e, $s");
      rethrow;
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _supabaseClient.auth.resetPasswordForEmail(email.trim());
      _log.i("Password reset email sent to $email");
    } on AuthException catch (e) {
      _log.w("Password reset email failed: $e");
      rethrow;
    } catch (e, s) {
      _log.e("Unexpected error sending password reset email: $e, $s");
      rethrow;
    }
  }

  bool isSignedIn() {
    return _supabaseClient.auth.currentUser != null;
  }
}
