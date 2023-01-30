import 'package:flutter/cupertino.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AppSnackBar {
  static void showError(BuildContext context, {required String message}) {
    showTopSnackBar(
      Overlay.of(context)!,
      CustomSnackBar.error(
        message: message,
      ),
    );
  }

  static void showInfo(BuildContext context, {required String message}) {
    showTopSnackBar(
      Overlay.of(context)!,
      displayDuration: const Duration(milliseconds: 1000),
      CustomSnackBar.info(
        message: message,
      ),
    );
  }
}
