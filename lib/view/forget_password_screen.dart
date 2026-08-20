import 'package:flutter/material.dart';
import 'package:moive_app/l10n/app_localizations.dart';
import 'package:moive_app/utils/app_colors.dart';
import 'package:moive_app/utils/app_images.dart';
import 'package:moive_app/utils/app_styles.dart';
import 'package:moive_app/utils/screen_utils.dart';
import 'package:moive_app/view/widgets/custom_elevated_button.dart';
import 'package:moive_app/view/widgets/custom_text_field.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = context.height;
    double width = context.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.yellowColor,
              size: 25,
            )),
        title: Text(
          AppLocalizations.of(context)!.forgetPassword,
          style: AppStyles.appbarTitleStyle,
        ),
        centerTitle: true,
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width*0.037,
          ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(AppImages.forgetPassword),
              CustomTextField(
                borderColor: AppColors.greyColor,
                preIcon: Icon(Icons.email,color: AppColors.whiteColor,),
                filled: true,
                fillColor: AppColors.greyColor,
                hintText: AppLocalizations.of(context)!.email,
                hintStyle: AppStyles.login,
              ),
              SizedBox(height: height*0.026,),
              CustomElevatedButton(
                onPressed: (){},
                backgroundColor: AppColors.yellowColor,
                foregroundColor: AppColors.blackColor,
                text: AppLocalizations.of(context)!.verifyEmail,
                borderColor: AppColors.yellowColor,
                textColor: AppColors.blackColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
