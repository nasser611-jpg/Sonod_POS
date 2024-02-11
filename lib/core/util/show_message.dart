import 'package:flutter/material.dart';

void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Color.fromARGB(146, 98, 198, 205),
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(20)),
      showCloseIcon: true,
      content: Center(
          child: Text(
        message,
        style: const TextStyle(fontWeight: FontWeight.w900),
      )),
      duration: const Duration(seconds: 2),
    ),
  );
}
