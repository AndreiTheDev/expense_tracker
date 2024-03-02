import 'package:flutter/material.dart';

import 'utils.dart';

SnackBar displayErrorSnackbar(final String errorMessage) {
  return SnackBar(
    backgroundColor: errorColor,
    content: Text(
      errorMessage,
      style: const TextStyle(color: Colors.white),
    ),
  );
}
