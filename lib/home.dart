import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PointOfSell"),
        centerTitle: true,
        backgroundColor: Colors.orange[300],
      ),
      body: const SafeArea(
        child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text('Welcome in POS App')
      ],)),
    );
  },
}
