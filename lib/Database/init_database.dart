import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper.internal();
  factory DbHelper() => _instance;
  DbHelper.internal();
  static Database? db;

  Future<Database> createDatabase() async {
    try {
      // Setup FFI bindings for sqflite
      sqfliteFfiInit();

      // Get the application documents directory
      final directory = await getApplicationDocumentsDirectory();

      final path = join(directory.path, 'pos.db');
      final backupDirectory = Directory(join(directory.path, 'backup'));

      if (!backupDirectory.existsSync()) {
        backupDirectory.createSync(recursive: true);
      }

      final backupPath = join(backupDirectory.path, 'pos_backup.db');

      // Check if the database file exists
      final databaseFile = File(path);
      final databaseExists = await databaseFile.exists();

      if (!databaseExists) {
        // If the database file doesn't exist, create one
        final newDatabase =
            await openDatabase(path, version: 1, onCreate: onCreate);
        await newDatabase.close();

        // Copy the newly created database to the backup directory
        await databaseFile.copy(backupPath);
        print('Initial database created and backed up successfully!');
      }

      final db = await openDatabase(path, version: 1, onUpgrade: onUpgrade);
      return db;
    } catch (e) {
      print('Error creating database: $e');
      rethrow;
    }
  }

  void onCreate(Database db, int version) {
    try {
      db.execute('''
        CREATE TABLE class (
          class_id INTEGER PRIMARY KEY AUTOINCREMENT,
          class_name TEXT NOT NULL
        );
      ''');

      db.execute('''
        CREATE TABLE products (
          product_id INTEGER PRIMARY KEY AUTOINCREMENT,
          product_name TEXT NOT NULL,
          price REAL,
          unit TEXT,
          class_id INTEGER,
          FOREIGN KEY (class_id) REFERENCES class(class_id)
        );
      ''');

      db.execute('''
        CREATE TABLE bill (
          bill_number INTEGER PRIMARY KEY AUTOINCREMENT,
          bill_type TEXT,
          class_id INTEGER,
          product_id INTEGER,
          quantity INTEGER,
          price REAL,
          unit TEXT,
          bill_amount REAL,
          paid_amount REAL,
          stayed_amount REAL,
          bill_time TEXT,
          FOREIGN KEY (class_id) REFERENCES class(class_id),
          FOREIGN KEY (product_id) REFERENCES products(product_id)
        );
      ''');

      print('OnCreate--------------');
    } catch (e) {
      print('Error executing onCreate: $e');
      rethrow;
    }
  }

  void onUpgrade(Database db, int oldVersion, int newVersion) {
    print('OnUpgrade--------------');
  }
}
