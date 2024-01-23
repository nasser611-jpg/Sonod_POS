import 'package:flutter/material.dart';
import 'package:sonod_point_of_sell/Database/init_database.dart';
import 'package:sonod_point_of_sell/home.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure that Flutter is initialized before executing the code.

  final dbHelper = DbHelper(); // Create an instance of your DbHelper

  // Initialize the database
  await dbHelper.createDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}
