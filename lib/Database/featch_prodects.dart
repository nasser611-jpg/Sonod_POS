import 'package:sonod_point_of_sell/Database/init_database.dart';
import 'package:sonod_point_of_sell/model/prodect_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<List<Product>> getProductsByClassId(int classId) async {
  DbHelper dbH = DbHelper();
  try {
    final db = await dbH.createDatabase();
    final List<Map<String, dynamic>> maps = await db.query(
      'products',
      where: 'class_id = ?',
      whereArgs: [classId],
    );

    return List.generate(maps.length, (i) {
      return Product(
        productId: maps[i]['product_id'],
        productName: maps[i]['product_name'],
        price: maps[i]['price'],
        unit: maps[i]['unit'],
        classId: maps[i]['class_id'],
      );
    });
  } catch (e) {
    print('Error getting products: $e');
    rethrow;
  }
}

Future<List<Product>> getProductsByProductId(int productId) async {
  DbHelper dbH = DbHelper();
  try {
    final db = await dbH.createDatabase();
    final List<Map<String, dynamic>> maps = await db.query(
      'products',
      where: 'product_id = ?',
      whereArgs: [productId],
    );

    return List.generate(maps.length, (i) {
      return Product(
        productId: maps[i]['product_id'],
        productName: maps[i]['product_name'],
        price: maps[i]['price'],
        unit: maps[i]['unit'],
        classId: maps[i]['class_id'],
      );
    });
  } catch (e) {
    print('Error getting products: $e');
    rethrow;
  }
}

Future<List<Product>> getFavoriteProducts() async {
  DbHelper dbH = DbHelper();
  Database db = await dbH.createDatabase();
  List<Map<String, dynamic>> favoriteProducts = await db.rawQuery('''
    SELECT * FROM products WHERE isFavorite = 1
  ''');

  return favoriteProducts.map((map) {
    return Product(
      productId: map['product_id'],
      productName: map['product_name'],
      price: map['price'],
      unit: map['unit'],
      classId: map['class_id'],
    );
  }).toList();
}
