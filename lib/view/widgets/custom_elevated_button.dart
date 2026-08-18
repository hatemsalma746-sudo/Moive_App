import 'package:flutter/material.dart';
import 'package:moive_app/utils/screen_utils.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton({super.key, required this.backgroundColor, required this.foregroundColor, this.onPressed, required this.text,required this.borderColor, required this.textColor,this.isImage = true,this.iconImage});


  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;
  final String text;
  final Color textColor;
  final void Function()? onPressed;
  final bool isImage;
  final AssetImage? iconImage;
  @override
  Widget build(BuildContext context) {
    double height = context.height;
    return SizedBox(
      width: double.infinity,
      height: height*0.06,
      child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(15),
          side: BorderSide(
              color: borderColor
          )
        ),
      ),
      child: isImage ? Text(
        text,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textColor
        ),
      ):
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
                ImageIcon(
                  iconImage,
                  size: 30,
                ),
              Text(
                text,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: textColor
                ),
              )
            ],
          )
      ),
    );
  }
}
