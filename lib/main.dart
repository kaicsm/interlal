import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/instance_manager.dart';
import 'package:interlal/app.dart';
import 'package:interlal/app/core/controllers/theme_controller.dart';
import 'package:interlal/app/core/services/database_service.dart';
import 'package:logger/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupSystemChrome();
  await initializeCoreServices();
  runApp(App());
}

Future<void> initializeCoreServices() async {
  await Get.putAsync<DatabaseService>(() async {
    final service = DatabaseService();
    await service.initializeDatabase();
    return service;
  }, permanent: true);

  Get.put<ThemeController>(ThemeController(), permanent: true);

  Logger().i("Core services initialized successfully.");
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
