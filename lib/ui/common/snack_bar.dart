import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:swaram_ai/app/app.locator.dart';

class SnackBarHelper {
  static void showSnackBar(
      {required String message,
      String title = "",
      required ContentType contentType}) {
    final snackBarKey = locator<GlobalKey<ScaffoldMessengerState>>();
    final snackBarContent = SnackBar(
        duration: const Duration(seconds: 5),
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          contentType: contentType,
          title: title,
          message: message,
        ));

    snackBarKey.currentState?.removeCurrentSnackBar();
    snackBarKey.currentState?.showSnackBar(snackBarContent);
  }
}
