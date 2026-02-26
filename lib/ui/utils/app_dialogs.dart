import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showLoading(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        content: Row(
          children: [Text("Loading..."), Spacer(), CircularProgressIndicator()],
        ),
      );
    },
  );
}

void showMessage(
    BuildContext context,
    String message, {
      String? title,
      String? posText,
      VoidCallback? onPosClick,
      String? negText,
      VoidCallback? onNegClick,
    }) {
  showDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: title != null ? Text(title) : null,
        content: Text(message),
        actions: [
          if (negText != null)
            TextButton(
              onPressed: onNegClick,
              child: Text(negText),
            ),
          if (posText != null)
            TextButton(
              onPressed: onPosClick,
              child: Text(posText),
            ),
        ],
      );
    },
  );
}
