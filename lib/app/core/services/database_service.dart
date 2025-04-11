import 'dart:io';

import 'package:get/state_manager.dart';
import 'package:interlal/app/data/models/app_settings.dart';
import 'package:isar/isar.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseService extends GetxService {
  static final Logger _log = Logger();
  static DatabaseService? _instance;

  late final Isar _isar;
  Isar get isarInstance => _isar;

  DatabaseService._internal();

  static Future<DatabaseService> init() async {
    if (_instance != null) return _instance!;
    final service = DatabaseService._internal();
    await service._initialize();
    return service;
  }

  Future<DatabaseService> _initialize() async {
    try {
      final Directory dir = await getApplicationDocumentsDirectory();
      final schemas = [AppSettingsSchema];

      _isar = await Isar.open(schemas, directory: dir.path);
      _log.i('Database initialized');
    } catch (e) {
      _log.e('Error initializing Isar: $e');
      rethrow;
    }
    return this;
  }
}
