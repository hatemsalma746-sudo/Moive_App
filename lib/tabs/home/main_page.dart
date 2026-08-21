import 'package:flutter/material.dart';
import 'package:moive_app/l10n/app_localizations.dart';
import 'package:moive_app/provider/app_language_provider.dart';
import 'package:moive_app/utils/app_colors.dart';
import 'package:moive_app/utils/app_images.dart';
import 'package:moive_app/utils/app_styles.dart';
import 'package:moive_app/utils/screen_utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MainPage> {
  int selectedIndex = 0;
  List<Widget> movies = [
    Image.asset(AppImages.blackPanther),
    Image.asset(AppImages.doctorStrange),
    Image.asset(AppImages.moive1917),
    Image.asset(AppImages.captainAmerica),
    Image.asset(AppImages.avengers),
  ];
  List<String> actionMovies = [
    AppImages.godzilla,
    AppImages.badBoys,
    AppImages.blackWidow,
    AppImages.ironMan,
    AppImages.captainAmerica,
  ];

  @override
  Widget build(BuildContext context) {
    double height = context.height;
    double width = context.width;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image(image: AssetImage(AppImages.moive1917), fit: BoxFit.fill),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.blackColor2, AppColors.blackColor3],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image(image: AssetImage(AppImages.available)),
                  SizedBox(
                    height: height * 0.35,
                    child: CarouselSlider.builder(
                      itemCount: movies.length,
                      itemBuilder:
                          (
                            BuildContext context,
                            int itemIndex,
                            int pageViewIndex,
                          ) => Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: width * 0.02,
                            ),
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Stack(
                                children: [
                                  Positioned.fill(child: movies[itemIndex]),
                                ],
                              ),
                            ),
                          ),
                      options: CarouselOptions(
                        height: height * 0.35,
                        viewportFraction: 0.45,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.3,
                        padEnds: true,
                        enableInfiniteScroll: false,
                      ),
                    ),
                  ),
                  Image(image: AssetImage(AppImages.watchNow)),
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.action,
                        style: AppStyles.descriptions,
                      ),
                      SizedBox(width: width * 0.55),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          AppLocalizations.of(context)!.seeMore,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            color: AppColors.yellowColor,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: AppColors.yellowColor,
                        size: width * 0.05,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.25,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: actionMovies.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: width * 0.28,
                          margin: EdgeInsets.only(right: width * 0.07),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusGeometry.circular(15),
                          ),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Image.asset(
                                  actionMovies[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: height * 0.01,
                                left: width * 0.01,
                                child: Row(
                                  children: [
                                    Text(
                                      "7.7",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 3),
                                    Icon(
                                      Icons.star,
                                      color: AppColors.yellowColor,
                                      size: 14,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
