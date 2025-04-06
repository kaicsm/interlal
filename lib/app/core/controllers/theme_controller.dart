import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:interlal/app/core/services/database_service.dart';
import 'package:interlal/app/data/models/app_settings.dart';
import 'package:logger/logger.dart';

class ThemeController extends GetxController {
  final Rx<ThemeMode> _themeMode = ThemeMode.system.obs;
  ThemeMode get themeMode => _themeMode.value;

  static const int _settingsId = 0;

  @override
  void onInit() {
    super.onInit();
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    try {
      final isar = Get.find<DatabaseService>().isarInstance;
      final settings = await isar.appSettings.get(_settingsId);

      if (settings != null) {
        Logger().i('Loaded theme preference');
        _updateThemeState(
          settings.themeMode,
          save: false,
        ); // Atualiza o estado do tema sem salvar novamente
      } else {
        Logger().i('No theme preference found');
        await _saveThemePreference(ThemeMode.system);
      }
    } catch (e) {
      Logger().e('Failed to load theme preference: $e');
      _updateThemeState(ThemeMode.system, save: false);
    }
  }

  Future<void> _saveThemePreference(ThemeMode mode) async {
    try {
      final isar = Get.find<DatabaseService>().isarInstance;
      await isar.writeTxn(() async {
        final settings =
            AppSettings()
              ..id = _settingsId
              ..themeMode = mode;
        await isar.appSettings.put(settings);
        Logger().i('Saved theme preference');
      });
    } catch (e) {
      Logger().e('Failed to save theme preference: $e');
    }
  }

  void _updateThemeState(ThemeMode mode, {bool save = true}) {
    if (_themeMode.value != mode) {
      _themeMode.value = mode;
      Get.changeThemeMode(mode);

      Logger().i('Updated theme state');
      if (save) {
        _saveThemePreference(mode);
      }
    }
  }

  void setThemeMode(ThemeMode mode) {
    _updateThemeState(mode, save: true);
  }
}
