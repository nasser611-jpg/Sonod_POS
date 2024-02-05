import 'package:flutter/material.dart';

class Keyboard extends StatefulWidget {
  const Keyboard({
    super.key,
    required this.onTap,
  });

  final Function(String) onTap;

  @override
  State<Keyboard> createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {
  List<String> keyname = [
    "تصفير",
    "9",
    "8",
    "7",
    "0",
    "6",
    "5",
    "4",
    "حذف",
    "3",
    "2",
    "1"
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GridView.builder(
            itemCount: 12,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, childAspectRatio: 1.6),
            itemBuilder: (context, index) => InkWell(
                  onTap: () => widget.onTap(keyname[index]),
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: const Color(0xff374957)),
                    child: Center(
                        child: Text(keyname[index],
                            style: const TextStyle(
                              color: Colors.white,
                            ))),
                  ),
                )));
  }
}