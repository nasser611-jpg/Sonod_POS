  import 'package:sonod_point_of_sell/Database/init_database.dart';
import 'package:sonod_point_of_sell/model/prodect_model.dart';

Future<List<Product>> getProductsByClassId(int classId) async {
  DbHelper dbH=DbHelper();
    try {
      final db = await dbH. createDatabase();
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