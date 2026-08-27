import 'package:flutter/material.dart';
import 'package:moive_app/utils/app_colors.dart';
import 'package:moive_app/utils/app_styles.dart';
import 'package:moive_app/utils/screen_utils.dart';

class BoxItemWidget extends StatelessWidget {
  const BoxItemWidget({super.key, this.icon, required this.text});


  final IconData? icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    double height = context.height;
    double width = context.width;
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: width*0.047,
            vertical: height*0.008
        ),
        decoration: BoxDecoration(
          color: AppColors.greyColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          spacing: 10,
          children: [
            Icon(icon,color: AppColors.yellowColor,),
            Text(text,style: AppStyles.headers,),
          ],
        ),
      ),
    );
  }
}
