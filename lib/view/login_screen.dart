import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:moive_app/l10n/app_localizations.dart';
import 'package:moive_app/model/firebase_model/user_model.dart';
import 'package:moive_app/provider/app_language_provider.dart';
import 'package:moive_app/provider/user_provider.dart';
import 'package:moive_app/utils/app_colors.dart';
import 'package:moive_app/utils/app_images.dart';
import 'package:moive_app/utils/app_route.dart';
import 'package:moive_app/utils/app_styles.dart';
import 'package:moive_app/utils/dialog_utils.dart';
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
  var formKey = GlobalKey<FormState>() ;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width*0.037,
            vertical: height*0.06
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
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
                    controller: emailController,
                    validator: (text) {
                      if (text == null || text
                          .trim()
                          .isEmpty) {
                        return "Enter Your Email";
                      }
                      final emailRegex = RegExp(
                          r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');

                      // 5. Test the input value against the regex
                      if (!emailRegex.hasMatch(emailController.text)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
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
                    sufIcon: IconButton(onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                        icon: Icon(isPasswordVisible ? Icons.visibility :
                        Icons.visibility_off,
                          color: AppColors.whiteColor,)),
                    filled: true,
                    fillColor: AppColors.greyColor,
                    hintText: AppLocalizations.of(context)!.password,
                    hintStyle: AppStyles.login,
                    controller: passwordController,
                    obscureText: !isPasswordVisible,
                    validator: (text) {
                      if (text == null || text
                          .trim()
                          .isEmpty) {
                        return "Enter Your Password";
                      }
                      if (text.length < 6) {
                        return 'Password should be at least 6 chars.';
                      }
                      return null;
                    },
                  ),
                      Align(
                        alignment: AlignmentGeometry.centerEnd,
                        child: TextButton(
                          onPressed: (){
                            Navigator.pushNamed(context, AppRoute.forgetPasswordScreen);
                          },
                          child: Text('${AppLocalizations.of(context)!.forgetPassword} ?',
                          style: AppStyles.smallYellowText,
                          ),
                        ),
                      ),
                  CustomElevatedButton(

                    onPressed: () {
                      loginButton();
                    },
                    backgroundColor: AppColors.yellowColor,
                    foregroundColor: AppColors.blackColor,
                    text: AppLocalizations.of(context)!.login,
                    borderColor: AppColors.yellowColor,
                    textColor: AppColors.blackColor,

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
                          // todo : Navigation to Register Screen
                          Navigator.pushNamed(context, AppRoute.registerScreen);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.createOne,
                          style: AppStyles.smallYellowText,
                        ),
                      ),
                    ],
                  ),
                  // todo : divider
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
                  // todo: login with google
                  CustomElevatedButton(
                      onPressed: (){
                        loginWithGoogle(context);
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

                      // todo : localization
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

  void loginButton() async {
    if (!formKey.currentState!.validate()) return;

    try {
      DialogUtils.showLoading(
        context: context,
        text: 'Loading..',
      );

      final credential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (!mounted) return;

      // Get User UID
      final uid = credential.user!.uid;

      // Get User Data From Firestore
      final userDoc = await FirebaseFirestore.instance
          .collection(Users.collectionName)
          .doc(uid)
          .get();

      if (!userDoc.exists) {
        DialogUtils.hideLoading(context: context);

        DialogUtils.showMessage(
          context: context,
          text: 'User data not found.',
          onPressed: () {
            Navigator.pop(context);
          },
        );

        return;
      }

      // Convert Firestore data to Users Model
      final user = Users.fromFirebaseStore(
        userDoc.data()!,
      );

      // Save User in Provider
      context.read<UserProvider>().updateUser(user);


      DialogUtils.hideLoading(context: context);

      DialogUtils.showMessage(
        context: context,
        text: 'Login Successful',
        onPressed: () {
          Navigator.pop(context);

          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoute.homeScreen,
                (route) => false,
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      DialogUtils.hideLoading(context: context);


      String message;

      switch (e.code) {
        case 'user-not-found':
          message = 'No user found with this email.';
          break;

        case 'wrong-password':
        case 'invalid-credential':
          message = 'Email or password is incorrect.';
          break;

        case 'invalid-email':
          message = 'The email address is not valid.';
          break;

        case 'user-disabled':
          message = 'This account has been disabled.';
          break;

        case 'too-many-requests':
          message = 'Too many attempts. Please try again later.';
          break;

        default:
          message = e.message ?? 'Login failed.';
      }

      DialogUtils.showMessage(
        context: context,
        text: message,
        onPressed: () {
          Navigator.pop(context);
        },
      );
    } catch (e) {
      if (!mounted) return;

      DialogUtils.hideLoading(context: context);

      DialogUtils.showMessage(
        context: context,
        text: 'Something went wrong. Please try again.',
        onPressed: () {
          Navigator.pop(context);
        },
      );
    }
  }

  Future<void> loginWithGoogle(BuildContext context) async {
    try {
      DialogUtils.showLoading(
        context: context,
        text: 'Loading...',
      );

      // Google Sign In
      final GoogleSignInAccount? googleUser =
      await GoogleSignIn().signIn();

      // User cancelled Google Sign In
      if (googleUser == null) {
        Navigator.pop(context);
        return;
      }

      // Get Google Auth
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      // Create Firebase Credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Firebase Login
      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      final firebaseUser = userCredential.user;

      if (firebaseUser == null) {
        throw Exception('Firebase user is null');
      }

      // Get user from Firestore
      final userDoc = await FirebaseFirestore.instance
          .collection(Users.collectionName)
          .doc(firebaseUser.uid)
          .get();

      late Users user;

      if (userDoc.exists) {
        user = Users.fromFirebaseStore(userDoc.data()!);
      } else {
        user = Users(
          id: firebaseUser.uid,
          name: firebaseUser.displayName ?? '',
          email: firebaseUser.email ?? '',
          phone: firebaseUser.phoneNumber ?? '',
          image: AppImages.gamer1,
        );

        await FirebaseFirestore.instance
            .collection(Users.collectionName)
            .doc(firebaseUser.uid)
            .set(
          user.toFirebaseStore(),
        );
      }

      // Save user in Provider
      Provider.of<UserProvider>(
        context,
        listen: false,
      ).updateUser(user);

      DialogUtils.showMessage(
          context: context,
          text: 'Successful',
          onPressed: (){
            Navigator.pop(context);

            Navigator.pushReplacementNamed(
              context,
              AppRoute.homeScreen,
            );
          }
      );

    } catch (e) {
      Navigator.pop(context);

      print('GOOGLE LOGIN ERROR: $e');
    }
  }
}
