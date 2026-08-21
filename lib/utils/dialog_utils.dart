import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoading({required BuildContext context,required String text}){
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children : [
                Text(
                  text,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
          ]
            ),
          );
        },
    );
  }

  static void hideLoading({
    required BuildContext context,
  })
  {
    Navigator.pop(context);
  }

  static void showMessage({
    required BuildContext context,
    required String text,
    required void Function()? onPressed,
  }){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(
            text,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),
          ),
          actions: [
            TextButton(
              onPressed: onPressed,
              child: Text(
            'Ok',
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold
            ),
            ),
            )
          ],
        );
      },
    );
  }
}