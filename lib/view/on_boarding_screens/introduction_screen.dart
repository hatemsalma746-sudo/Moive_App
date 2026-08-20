import 'package:flutter/material.dart';
import 'package:moive_app/l10n/app_localizations.dart';
import 'package:moive_app/utils/app_colors.dart';
import 'package:moive_app/utils/app_images.dart';
import 'package:moive_app/utils/app_route.dart';
import 'package:moive_app/utils/app_styles.dart';
import 'package:moive_app/utils/screen_utils.dart';
import 'package:moive_app/view/widgets/custom_elevated_button.dart';


class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = context.height;
    double width = context.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                AppColors.greyColor,
                AppColors.blackColor,
                AppColors.blackColor,
                AppColors.blackColor,
              ],
            begin: AlignmentGeometry.topCenter,
            end: AlignmentGeometry.bottomCenter
          ),
          image: DecorationImage(
            image: AssetImage(AppImages.moviesPosters1),
            fit: BoxFit.fill,
            opacity: 0.6,
          )
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width*0.037,
            vertical: height*0.035
          ),
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                AppLocalizations.of(context)!.introTitle,
                style: AppStyles.header1,
                textAlign: TextAlign.center,
              ),
              Text(
                AppLocalizations.of(context)!.introDescription,
                style: AppStyles.descriptions,
                textAlign: TextAlign.center,
              ),
              CustomElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context, AppRoute.onBoardingScreen);
                },
                borderColor: AppColors.yellowColor,
                backgroundColor: AppColors.yellowColor,
                foregroundColor: AppColors.blackColor,
                text: AppLocalizations.of(context)!.exploreNow,
                textColor: AppColors.blackColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
