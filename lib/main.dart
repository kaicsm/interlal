import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/instance_manager.dart';
import 'package:interlal/app.dart';
import 'package:interlal/app/core/controllers/theme_controller.dart';
import 'package:interlal/app/core/services/auth_service.dart';
import 'package:interlal/app/core/services/database_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupSystemChrome();

  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  await initializeServices();

  runApp(App());
}

Future<void> initializeServices() async {
  await Get.putAsync<DatabaseService>(() => DatabaseService.init());
  Get.lazyPut<AuthService>(() => AuthService(), fenix: true);
  Get.lazyPut<ThemeController>(() => ThemeController(), fenix: true);
}

void setupSystemChrome() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemStatusBarContrastEnforced: false,
      systemNavigationBarContrastEnforced: false,
    ),
  );
}
