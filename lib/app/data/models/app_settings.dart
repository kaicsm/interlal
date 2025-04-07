import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

part 'app_settings.g.dart';

@collection
class AppSettings {
  Id id = 0;

  // 0 -> system, 1 -> light, 2 -> dark
  @enumerated
  late ThemeMode themeMode;

  AppSettings();
}
