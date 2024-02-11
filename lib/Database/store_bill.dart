import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sonod_point_of_sell/Database/init_database.dart';
import 'package:sonod_point_of_sell/core/util/formatted_proudct.dart';

Future<void> insertBill({
  required List<FormattedProduct> formattedProduct,
  required String billDate,
  required double paidAmount,
  required double stayedAmount,
  required double total,
}) async {
  try {
    DbHelper dbH = DbHelper();
    Database db = await dbH.createDatabase();

    if (formattedProduct.isNotEmpty) {
      // If formattedProduct list is not empty, print its elements
      print('the Formatted List is Empty Mr Nasser');
    } else {
      // If formattedProduct list is empty, print a message
      print('No products to insert.');
    }

    // Inserting default values into the bills table
    int billId = await db.rawInsert('''
      INSERT INTO bills (bill_date, paid_amount, stayed_amount, bill_type, total)
      VALUES (?, ?, ?, ?, ?)
    ''', [billDate, paidAmount, stayedAmount, 'نقداً', total]);

    if (billId != -1) {
      print('Bill inserted successfully with ID: $billId');

      // Inserting product details into the products_bill table and establishing relationship
      for (var formattedProduct in formattedProduct) {
        try {
          // Inserting product details into the products_bill table
          int? productId = await db.rawInsert('''
            INSERT INTO products_bill (product_name, price, unit, quantity)
            VALUES (?, ?, ?, ?)
          ''', [
            formattedProduct.productName,
            formattedProduct.price,
            formattedProduct.unit,
            formattedProduct.count
          ]);

          if (productId != -1) {
            // Inserting entry into the bill_products table to establish relationship
            await db.rawInsert('''
              INSERT INTO bill_products (bill_id, product_id)
              VALUES (?, ?)
            ''', [billId, productId]);
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

Future<int> addFavoriteProduc(int isFavorite, int productId) async {
  try {
    DbHelper dbH = DbHelper();
    Database db = await dbH.createDatabase();

    // Updating data in the products table where product_id matches the provided productId
    await db.rawUpdate('''
      UPDATE products 
      SET isFavorite = ?
      WHERE product_id = ?
    ''', [isFavorite, productId]);

    // Returning a value indicating success (1)
    return 1;
  } catch (e) {
    print("Error updating data: $e");
    return 0; // Handle error accordingly
  }
}

Future<int> getIsFavorite(int productId) async {
  try {
    DbHelper dbH = DbHelper();
    Database db = await dbH.createDatabase();

    // Querying the products table to retrieve isFavorite where product_id matches the provided productId
    List<Map<String, dynamic>> result = await db.query(
      'products',
      columns: ['isFavorite'],
      where: 'product_id = ?',
      whereArgs: [productId],
    );

    // Extracting and returning the isFavorite value
    if (result.isNotEmpty) {
      dynamic isFavoriteValue = result.first['isFavorite'];
      // Check if the value is not null before attempting to cast it to int
      if (isFavoriteValue != null) {
        return isFavoriteValue as int; // Return the value if it's not null
      } else {
        // Return a default value indicating the value is null
        return 0;
      }
    } else {
      // Return a default value indicating not found (you may handle this differently based on your needs)
      return 0;
    }
  } catch (e) {
    print("Error retrieving data: $e");
    return 9; // Handle error accordingly
  }
}
