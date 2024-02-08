// Method to calculate the sum of the IDs of bills


  // Method to retrieve the ID of the last bill
  import 'package:sonod_point_of_sell/Database/init_database.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<int> lastBillId() async {
  DbHelper dbO = DbHelper();
  Database db = await dbO.createDatabase();
  final List<Map<String, dynamic>> result =
      await db.rawQuery('SELECT MAX(bill_id) as max_id FROM bills');
  final int lastId = result.isNotEmpty && result.first['max_id'] != null
      ? result.first['max_id'] as int
      : 0;
  return lastId;
}

Future<String> lastBillDate() async {
  DbHelper dbO = DbHelper();
  Database db = await dbO.createDatabase();
  final List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT bill_date FROM bills ORDER BY bill_id DESC LIMIT 1');
  if (result.isNotEmpty && result.first['bill_date'] != null) {
    final String lastDate = result.first['bill_date'] as String;
    return lastDate;
  } else {
    return ''; // Return an empty string if no bill is found
  }
}
