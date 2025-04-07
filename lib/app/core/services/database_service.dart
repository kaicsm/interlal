import 'dart:io';

import 'package:get/state_manager.dart';
import 'package:interlal/app/data/models/app_settings.dart';
import 'package:isar/isar.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseService extends GetxService {
  Isar? _isar;
  Isar get isarInstance => _isar!;

  Future<DatabaseService> initializeDatabase() async {
    if (_isar == null) {
      try {
        final Directory dir = await getApplicationDocumentsDirectory();
        _isar = await Isar.open([AppSettingsSchema], directory: dir.path);
        Logger().i('Database initialized');
      } catch (e) {
        Logger().e('Error initializing Isar: $e');
        rethrow;
      }
    }
    return this;
  }
}