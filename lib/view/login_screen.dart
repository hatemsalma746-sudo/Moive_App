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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width*0.037,
            vertical: height*0.06
          ),
          child: Column(
            spacing: height*0.024,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: width*0.3,
                height: height*0.13,
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
                hintText: AppLocalizations.of(context)!.password,
                hintStyle: AppStyles.login,
              ),
                  Align(
                    alignment: AlignmentGeometry.centerEnd,
                    child: TextButton(
                      onPressed: (){

                      },
                      child: Text('${AppLocalizations.of(context)!.forgetPassword} ?',
                      style: AppStyles.smallYellowText,
                      ),
                    ),
                  ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.doNotHaveAccount,
                    style: AppStyles.smallWhiteText,
                  ),
                  TextButton(
                    onPressed: (){

                    },
                    child: Text(
                      AppLocalizations.of(context)!.createOne,
                      style: AppStyles.smallYellowText,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: AppColors.yellowColor,
                      thickness: 2,
                      indent: width * 0.04,
                      endIndent: width * 0.04,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.oR,
                    style: AppStyles.smallYellowText,
                  ),
                  Expanded(
                    child: Divider(
                      color: AppColors.yellowColor,
                      thickness: 2,
                      indent: width * 0.04,
                      endIndent: width * 0.04,
                    ),
                  ),
                ],
              ),
              CustomElevatedButton(
                  onPressed: (){
                  },
                  backgroundColor: AppColors.yellowColor,
                  foregroundColor: AppColors.blackColor,
                  text: AppLocalizations.of(context)!.loginWithGoogle,
                  borderColor: AppColors.yellowColor,
                  textColor: AppColors.blackColor,
                  isImage: false,
                  iconImage:  AssetImage(AppImages.googleIcon),
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
