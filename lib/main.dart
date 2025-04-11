import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/instance_manager.dart';
import 'package:interlal/app.dart';
import 'package:interlal/app/core/controllers/theme_controller.dart';
import 'package:interlal/app/core/services/database_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupSystemChrome();

  await initializeServices();

  runApp(App());
}

Future<void> initializeServices() async {
  await Get.putAsync<DatabaseService>(() => DatabaseService.init());
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
