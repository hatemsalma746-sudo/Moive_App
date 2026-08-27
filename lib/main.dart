import 'package:flutter/material.dart';
import 'package:moive_app/firebase_options.dart';
import 'package:moive_app/l10n/app_localizations.dart';
import 'package:moive_app/provider/app_language_provider.dart';
import 'package:moive_app/provider/user_provider.dart';
import 'package:moive_app/tabs/update_profile/update_profile_screen.dart';
import 'package:moive_app/utils/app_route.dart';
import 'package:moive_app/utils/app_theme.dart';
import 'package:moive_app/view/forget_password_screen.dart';
import 'package:moive_app/view/home_screen.dart';
import 'package:moive_app/view/login_screen.dart';
import 'package:moive_app/view/movies_details.dart';
import 'package:moive_app/view/on_boarding_screens/introduction_screen.dart';
import 'package:moive_app/view/on_boarding_screens/onboarding_screen.dart';
import 'package:moive_app/view/register_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );



  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => AppLanguageProvider()),
      ChangeNotifierProvider(create: (context) => UserProvider()),
    ],
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    return MaterialApp(
      theme: AppTheme.themeData,
      darkTheme: AppTheme.themeData,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.introductionScreen,
      locale: Locale(languageProvider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routes: {
        AppRoute.introductionScreen : (context) => IntroductionScreen(),
        AppRoute.onBoardingScreen : (context) => OnboardingScreen(),
        AppRoute.loginScreen : (context) => LoginScreen(),
        AppRoute.registerScreen : (context) => RegisterScreen(),
        AppRoute.homeScreen : (context) => HomeScreen(),
        AppRoute.forgetPasswordScreen : (context) => ForgetPasswordScreen(),
        AppRoute.updateProfileScreen : (context) => UpdateProfileScreen(),
        AppRoute.moviesDetails : (context) => MoviesDetails(),
      },
    );
  }
}