import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moive_app/l10n/app_localizations.dart';
import 'package:moive_app/model/firebase_model/user_model.dart';
import 'package:moive_app/provider/app_language_provider.dart';
import 'package:moive_app/provider/user_provider.dart';
import 'package:moive_app/utils/app_colors.dart';
import 'package:moive_app/utils/app_images.dart';
import 'package:moive_app/utils/app_styles.dart';
import 'package:moive_app/utils/dialog_utils.dart';
import 'package:moive_app/utils/screen_utils.dart';
import 'package:moive_app/view/widgets/custom_elevated_button.dart';
import 'package:moive_app/view/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  final List<String> avatars = [
    AppImages.gamer1,
    AppImages.gamer2,
    AppImages.gamer3,
    AppImages.gamer4,
    AppImages.gamer5,
    AppImages.gamer6,
    AppImages.gamer7,
    AppImages.gamer8,
    AppImages.gamer9,
  ];

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
bool isPasswordVisible = false;

  int selectedAvatar = 0;


class _RegisterScreenState extends State<RegisterScreen> {


  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;

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
            child: Form(
              key: formKey,
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
                                setState(() {
                                  selectedAvatar = index;
                                });
                              },
                            ),
                            carouselController: CarouselSliderController(),
                    itemCount: widget.avatars.length,
                    itemBuilder: (context, index, realIndex) {
                      return Image.asset(
                        widget.avatars[index],
                        height: 200,
                        width: 200,
                        fit: BoxFit.contain,
                      );
                    },
                  ),
                  CustomTextField(
                    controller: nameController,
                    borderColor: AppColors.greyColor,
                    preIcon: Icon(Icons.person,color: AppColors.whiteColor,),
                    filled: true,
                    fillColor: AppColors.greyColor,
                    hintText: AppLocalizations.of(context)!.name,
                    hintStyle: AppStyles.login,
                  ),
                  CustomTextField(
                    controller: emailController,
                    borderColor: AppColors.greyColor,
                    preIcon: Icon(Icons.email,color: AppColors.whiteColor,),
                    filled: true,
                    fillColor: AppColors.greyColor,
                    hintText: AppLocalizations.of(context)!.email,
                    hintStyle: AppStyles.login,
                  ),
                  CustomTextField(
                    controller: passwordController,
                    borderColor: AppColors.greyColor,
                    preIcon: Icon(Icons.lock,color: AppColors.whiteColor,),
                    sufIcon: IconButton(onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    }, icon: Icon(isPasswordVisible ? Icons.visibility :
                    Icons.visibility_off,
                      color: AppColors.whiteColor,)),
                    filled: true,
                    fillColor: AppColors.greyColor,
                    hintText: AppLocalizations.of(context)!.password,
                    hintStyle: AppStyles.login,
                    obscureText: !isPasswordVisible,

                  ),
                  CustomTextField(
                    controller: confirmPasswordController,
                    borderColor: AppColors.greyColor,
                    preIcon: Icon(Icons.lock,color: AppColors.whiteColor,),
                    sufIcon: IconButton(onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    }, icon: Icon(isPasswordVisible ? Icons.visibility :
                    Icons.visibility_off,
                      color: AppColors.whiteColor,)),
                    filled: true,
                    fillColor: AppColors.greyColor,
                    hintText: AppLocalizations.of(context)!.confirmPassword,
                    hintStyle: AppStyles.login,
                    obscureText: !isPasswordVisible,
                  ),
                  CustomTextField(
                    controller: phoneController,
                    borderColor: AppColors.greyColor,
                    preIcon: Icon(Icons.phone,color: AppColors.whiteColor,),
                    filled: true,
                    fillColor: AppColors.greyColor,
                    hintText: AppLocalizations.of(context)!.phoneNumber,
                    hintStyle: AppStyles.login,
                    lableStyle: AppStyles.login,
                  ),CustomElevatedButton(
                      onPressed: register,
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

                      //  todo: localization
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

  Future<void> register() async {
    try {
      DialogUtils.showLoading(
        context: context,
        text: 'Loading..',
      );

      print('START REGISTER');

      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      print('AUTH SUCCESS');

      final firebaseUser = credential.user;

      if (firebaseUser == null) {
        DialogUtils.hideLoading(context: context);
        return;
      }

      print('UID: ${firebaseUser.uid}');

      final user = Users(
        id: firebaseUser.uid,
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        image: widget.avatars[selectedAvatar],
      );

      await FirebaseFirestore.instance
          .collection(Users.collectionName)
          .doc(firebaseUser.uid)
          .set(
        user.toFirebaseStore(),
      );

      print('FIRESTORE SUCCESS');

      if (!mounted) return;

      // Save user data in Provider
      context.read<UserProvider>().updateUser(user);

      DialogUtils.hideLoading(context: context);

      DialogUtils.showMessage(
        context: context,
        text: 'Successful',
        onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      DialogUtils.hideLoading(context: context);

      String message;

      switch (e.code) {
        case 'email-already-in-use':
          message = 'This email is already registered.';
          break;

        case 'invalid-email':
          message = 'The email address is not valid.';
          break;

        case 'weak-password':
          message = 'The password is too weak.';
          break;

        case 'operation-not-allowed':
          message = 'Email/password authentication is not enabled.';
          break;

        default:
          message = e.message ?? 'Registration failed.';
      }

      DialogUtils.showMessage(
        context: context,
        text: message,
        onPressed: () {
          Navigator.pop(context);
        },
      );

      print('REGISTER AUTH ERROR: ${e.code}');
    } catch (e) {
      if (!mounted) return;

      DialogUtils.hideLoading(context: context);

      print('REGISTER ERROR: $e');

      DialogUtils.showMessage(
        context: context,
        text: 'Something went wrong. Please try again.',
        onPressed: () {
          Navigator.pop(context);
        },
      );
    }
  }
}
