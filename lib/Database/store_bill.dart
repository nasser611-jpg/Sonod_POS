import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sonod_point_of_sell/Database/init_database.dart';
import 'package:sonod_point_of_sell/core/util/formatted_proudct.dart';


Future<void> insertBill({
  required List<FormattedProduct> formattedProduct,
  required String billDate,
  required double paid_amount,
  required double stayed_amount,
  required double total,
}) async {
  try {
    DbHelper dbH = DbHelper();
    Database db = await dbH.createDatabase();
    
    // Inserting default values into the bills table
    int billId = await db.rawInsert('''
      INSERT INTO bills (bill_date, paid_amount, stayed_amount, bill_type, total)
      VALUES (?, ?, ?, ?, ?)
    ''', [billDate, paid_amount, stayed_amount, 'نقداً', total]);

    if (billId != -1) {
      print('Bill inserted successfully with ID: $billId');

      // Inserting default values into the products table
      for (var formattedProduct in formattedProduct) {
        try {
          int? productId = await db.rawInsert('''
            INSERT INTO products_bill (product_name, price, unit, quantity)
            VALUES (?, ?, ?, ?)
          ''', [formattedProduct.productName, formattedProduct.price, formattedProduct.unit, formattedProduct.count]);

          if (productId != -1) {
            print('Product inserted successfully with ID: $productId');

            // Inserting default values into the bill_products table
            await db.rawInsert('''
              INSERT INTO bill_products (bill_id, product_id)
              VALUES (?, ?)
            ''', [billId, productId]);

            print('Relation entry inserted successfully');
          } else {
            print('Error: Product insertion failed');
            // Handle the case where product insertion failed
          }
        } catch (error) {
          print('Error inserting product: $error');
          // Handle any errors that occur during the product insertion
        }
      }
    } else {
      print('Error: Bill insertion failed');
      // Handle the case where bill insertion failed
    }
  } catch (error) {
    print('Error inserting bill: $error');
    // Handle any errors that occur during the bill insertion
  }
}
