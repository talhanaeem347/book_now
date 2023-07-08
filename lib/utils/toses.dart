import 'package:flutter/material.dart';

void showFailureTos(String message, BuildContext context) {
  ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ),
  );
}


void showSuccessTos(String message, BuildContext context) {
  ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
    ),
  );
}

void showInfoTos(String message, BuildContext context) {
  ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.blue,
    ),
  );
}