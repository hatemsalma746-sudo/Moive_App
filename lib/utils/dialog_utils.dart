import 'package:flutter/material.dart';
import 'package:moive_app/utils/app_colors.dart';

class DialogUtils {
  static void showLoading({required BuildContext context,required String text}){
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.blackColor,
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children : [
                Text(
                  text,
                  style: TextStyle(
                      color: AppColors.whiteColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                CircularProgressIndicator(
                  color: AppColors.yellowColor,
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
          backgroundColor: AppColors.blackColor,
          content: Text(
            text,
            style: TextStyle(
                color: AppColors.whiteColor,
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
                color: AppColors.whiteColor,
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