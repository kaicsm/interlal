import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interlal/app/core/controllers/theme_controller.dart';
import 'package:interlal/app/routes/app_pages.dart';
import 'package:interlal/app/utils/app_theme.dart';

class App extends StatelessWidget {
  App({super.key});

  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        title: "Interlal",
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeController.themeMode,
        initialRoute: AppPages.initial,
        getPages: AppPages.routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
