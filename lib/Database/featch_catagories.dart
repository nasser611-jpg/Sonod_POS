

 import 'package:sonod_point_of_sell/Database/init_database.dart';
import 'package:sonod_point_of_sell/model/catag_model.dart';

Future<List<Class>> getAllClasses() async {
  DbHelper dbH=DbHelper();
  final db = await dbH.createDatabase();
  final List<Map<String, dynamic>> maps = await db.query('class');

  return List.generate(maps.length, (i) {
    return Class(
      classId: maps[i]['class_id'],
      className: maps[i]['class_name'],
    );
  });
}