import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:moive_app/l10n/app_localizations.dart';
import 'package:moive_app/provider/app_language_provider.dart';
import 'package:moive_app/utils/app_colors.dart';
import 'package:moive_app/utils/app_images.dart';
import 'package:moive_app/utils/app_styles.dart';
import 'package:moive_app/utils/screen_utils.dart';
import 'package:moive_app/view/widgets/custom_elevated_button.dart';
import 'package:moive_app/view/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});


  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;

    List<Widget> avatar = [
      Image.asset(AppImages.gamer1,height: 200,width: 200,fit: BoxFit.contain,),
      Image.asset(AppImages.gamer2,height: 200,width: 200,fit: BoxFit.contain,),
      Image.asset(AppImages.gamer3,height: 200,width: 200,fit: BoxFit.contain,),
      Image.asset(AppImages.gamer4,height: 200,width: 200,fit: BoxFit.contain,),
      Image.asset(AppImages.gamer5,height: 200,width: 200,fit: BoxFit.contain,),
      Image.asset(AppImages.gamer6,height: 200,width: 200,fit: BoxFit.contain,),
      Image.asset(AppImages.gamer7,height: 200,width: 200,fit: BoxFit.contain,),
      Image.asset(AppImages.gamer8,height: 200,width: 200,fit: BoxFit.contain,),
      Image.asset(AppImages.gamer9,height: 200,width: 200,fit: BoxFit.contain,),
    ];

    var languageProvider = Provider.of<AppLanguageProvider>(context);
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
          AppLocalizations.of(context)!.register,
          style: AppStyles.appbarTitleStyle,
        ),
        centerTitle: true,
      ),
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width*0.037,
          ),
          child: SingleChildScrollView(
            child: Column(
              spacing: height*0.024,
              children: [
                CarouselSlider.builder(
                          options: CarouselOptions(
                            height: height * 0.17,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.5,
                            viewportFraction: 0.30,
                            disableCenter: false,
                            padEnds: true,
                            scrollDirection: Axis.horizontal,
            
                            onPageChanged: (index, reason) {
                // current index هنا
                            },
                          ),
                          carouselController: CarouselSliderController(),
                  itemCount: avatar.length,
                  itemBuilder: (context, index, realIndex) =>
                      avatar[index],
                ),
                CustomTextField(
                  borderColor: AppColors.greyColor,
                  preIcon: Icon(Icons.person,color: AppColors.whiteColor,),
                  filled: true,
                  fillColor: AppColors.greyColor,
                  hintText: AppLocalizations.of(context)!.name,
                  hintStyle: AppStyles.login,
                ),
                CustomTextField(
                  borderColor: AppColors.greyColor,
                  preIcon: Icon(Icons.email,color: AppColors.whiteColor,),
                  filled: true,
                  fillColor: AppColors.greyColor,
                  hintText: AppLocalizations.of(context)!.email,
                  hintStyle: AppStyles.login,
                ),
                CustomTextField(
                  borderColor: AppColors.greyColor,
                  preIcon: Icon(Icons.lock,color: AppColors.whiteColor,),
                  filled: true,
                  fillColor: AppColors.greyColor,
                  hintText: AppLocalizations.of(context)!.confirmPassword,
                  hintStyle: AppStyles.login,
                ),
                CustomTextField(
                  borderColor: AppColors.greyColor,
                  preIcon: Icon(Icons.lock,color: AppColors.whiteColor,),
                  filled: true,
                  fillColor: AppColors.greyColor,
                  hintText: AppLocalizations.of(context)!.password,
                  hintStyle: AppStyles.login,
                ),
                CustomTextField(
                  borderColor: AppColors.greyColor,
                  preIcon: Icon(Icons.phone,color: AppColors.whiteColor,),
                  filled: true,
                  fillColor: AppColors.greyColor,
                  hintText: AppLocalizations.of(context)!.phoneNumber,
                  hintStyle: AppStyles.login,
                ),CustomElevatedButton(
                    onPressed: (){
            
                    },
                    backgroundColor: AppColors.yellowColor,
                    foregroundColor: AppColors.blackColor,
                    text: AppLocalizations.of(context)!.createAccount,
                    borderColor: AppColors.yellowColor,
                    textColor: AppColors.blackColor,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.alreadyHaveAccount,
                      style: AppStyles.smallWhiteText,
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.login,
                        style: AppStyles.smallYellowText,
                      ),
                    ),
                  ],
                ),
                UnconstrainedBox(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                            color: AppColors.yellowColor,
                            width: 3
                        )
                    ),
                    child: Row(
                      spacing: 5,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: (){
                              languageProvider.updateLanguage('en');
                            },
                            child: languageProvider.appLanguage == 'en'?
                            selectedEnIcon() :
                            unSelectedEnIcon()
                        ),
                        InkWell(
                            onTap: (){
                              languageProvider.updateLanguage('ar');
                            },
                            child: languageProvider.appLanguage == 'ar'?
                            selectedArIcon() :
                            unSelectedArIcon()
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget selectedArIcon(){
    return CircleAvatar(
        backgroundColor: AppColors.yellowColor,
        child: Image.asset(
            'assets/images/EG.png',
            fit: BoxFit.cover
        )
    );
  }

  Widget unSelectedArIcon(){
    return CircleAvatar(
        backgroundColor: AppColors.blackColor,
        child: Image.asset(
            'assets/images/EG.png',
            fit: BoxFit.cover
        )
    );
  }

  Widget selectedEnIcon(){
    return CircleAvatar(
        backgroundColor: AppColors.yellowColor,
        child: Image.asset(
            'assets/images/LR.png',
            fit: BoxFit.cover
        )
    );
  }

  Widget unSelectedEnIcon(){
    return CircleAvatar(
        backgroundColor: AppColors.blackColor,
        child: Image.asset(
            'assets/images/LR.png',
            fit: BoxFit.cover
        )
    );
  }
}
