 import 'package:flutter/material.dart';

void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(child: Text(message)),
        duration: const Duration(seconds: 2),
      ),
    );
  }