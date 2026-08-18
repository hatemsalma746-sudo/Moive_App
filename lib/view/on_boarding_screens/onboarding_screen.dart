import 'package:flutter/material.dart';
import 'package:moive_app/l10n/app_localizations.dart';
import 'package:moive_app/utils/app_colors.dart';
import 'package:moive_app/utils/app_images.dart';
import 'package:moive_app/utils/app_route.dart';
import 'package:moive_app/utils/app_styles.dart';
import 'package:moive_app/utils/screen_utils.dart';
import 'package:moive_app/view/widgets/custom_elevated_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  int currentIndex = 0;

  List<String> onboardingImage = [
    AppImages.marvelPoster,
    AppImages.godFather1,
    AppImages.badBoys,
    AppImages.doctorStrange,
    AppImages.moive1917
  ];


  @override
  Widget build(BuildContext context) {
    double height = context.height;
    double width = context.width;

    List<String> onboardingTitle = [
      AppLocalizations.of(context)!.onBoardingTitle1,
      AppLocalizations.of(context)!.onBoardingTitle2,
      AppLocalizations.of(context)!.onBoardingTitle3,
      AppLocalizations.of(context)!.onBoardingTitle4,
      AppLocalizations.of(context)!.onBoardingTitle5,
    ];

    List<String> onboardingDescription = [
      AppLocalizations.of(context)!.onBoardingDescription1,
      AppLocalizations.of(context)!.onBoardingDescription2,
      AppLocalizations.of(context)!.onBoardingDescription3,
      AppLocalizations.of(context)!.onBoardingDescription4,
      ''
    ];
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: PageView(

        children: [
          Stack(
          alignment: AlignmentGeometry.bottomCenter,
          children:[
            Container(
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(onboardingImage[currentIndex]),
                  fit: BoxFit.fill,
                )
            ),
                    ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColors.blackColor,
              borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30)
            )
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width*0.037,
              vertical: height*0.027,
            ),
            child: Column(
              spacing: 20,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  onboardingTitle[currentIndex],
                  style: AppStyles.headers,
                  textAlign: TextAlign.center,
                ),
                Text(
                  onboardingDescription[currentIndex],
                  style: AppStyles.descriptions,
                  textAlign: TextAlign.center,
                ),
                currentIndex > 0 ?
                Column(
                  spacing: height*0.017,
                  children: [
                    CustomElevatedButton(
                        onPressed: (){
                          if(currentIndex < 4){
                            currentIndex++;
                          }
                          else{
                            Navigator.pushNamed(context, AppRoute.loginScreen);
                          }

                          setState(() {

                          });
                        },
                        borderColor: AppColors.yellowColor,
                        backgroundColor: AppColors.yellowColor,
                        foregroundColor: AppColors.blackColor,
                        text: currentIndex == 4 ? AppLocalizations.of(context)!.finish
                            : AppLocalizations.of(context)!.next,
                        textColor: AppColors.blackColor,
                    ),
                    CustomElevatedButton(
                        onPressed: (){
                          currentIndex--;
                          setState(() {

                          });
                        },
                        borderColor: AppColors.yellowColor,
                        backgroundColor: AppColors.blackColor,
                        foregroundColor: AppColors.yellowColor,
                        text: AppLocalizations.of(context)!.back,
                        textColor: AppColors.yellowColor,
                    )
                  ],
                ) :
                CustomElevatedButton(
                    onPressed: (){
                      currentIndex++;
                      setState(() {

                      });
                    },
                    borderColor: AppColors.yellowColor,
                    backgroundColor: AppColors.yellowColor,
                    foregroundColor: AppColors.blackColor,
                    text: AppLocalizations.of(context)!.next,
                    textColor: AppColors.blackColor,

                ),
              ],
            ),
          ),
        )
          ],
        ),
      ]
      ),
    );
  }
}
