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
            await openDatabase(path, version: 7, onCreate: onCreate);
        await newDatabase.close();

        // Copy the newly created database to the backup directory
        await databaseFile.copy(backupPath);
        print('Initial database created and backed up successfully!');
      }

      final db = await openDatabase(path, version: 5, onUpgrade: onUpgrade);
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
          isFavorite INTEGER,
          FOREIGN KEY (class_id) REFERENCES class(class_id)
        );
      ''');

      db.execute('''
      CREATE TABLE bills (
        bill_id INTEGER PRIMARY KEY AUTOINCREMENT,
        bill_date TEXT,
        paid_amount REAL,
        stayed_amount REAL,
        total REAL,
        bill_type TEXT 
      )
    ''');

      db.execute('''
      CREATE TABLE bill_products (
        bill_products_id INTEGER PRIMARY KEY AUTOINCREMENT,
        bill_id INTEGER REFERENCES bills(bill_id),
        product_id INTEGER REFERENCES products_bill(product_id)
      )
    ''');

      db.execute('''
      CREATE TABLE products_bill (
        product_id INTEGER PRIMARY KEY AUTOINCREMENT,
        product_name TEXT,
        classs TEXT,
        price REAL,
        unit TEXT,
        quantity INTEGER
      )
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
