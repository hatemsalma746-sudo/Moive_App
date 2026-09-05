import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:moive_app/l10n/app_localizations.dart';
import 'package:moive_app/model/movies_list/movies.dart';
import 'package:moive_app/services/movie_service.dart';
import 'package:moive_app/utils/app_colors.dart';
import 'package:moive_app/utils/app_images.dart';
import 'package:moive_app/utils/app_route.dart';
import 'package:moive_app/utils/app_styles.dart';
import 'package:moive_app/utils/screen_utils.dart';


class MainPage extends StatefulWidget {
  final VoidCallback onSeeMore;

  const MainPage({
    super.key,
    required this.onSeeMore,
  });

  @override
  State<MainPage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MainPage> {
  int selectedIndex = 0;

  List<Movies> movies = [];
  List<Movies> actionMovies = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadMovies();
  }

  Future<void> loadMovies() async {
    try {
      final allMovies = await MovieService.fetchMovies();
      final action = allMovies
          .where((m) => m.genres?.contains('Action') ?? false)
          .toList();

      setState(() {
        movies = allMovies;
        actionMovies = action.isNotEmpty ? action : allMovies;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = context.height;
    double width = context.width;

    if (isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator(
          color: AppColors.yellowColor,
        )),
      );
    }

    if (errorMessage != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context)!
                  .somethingWentWrongWhileLoadingTheMovies
                , style: AppStyles.appbarTitleStyle,),

              TextButton(
                onPressed: () {
                  setState(() => isLoading = true);
                  loadMovies();
                },
                child: Text(AppLocalizations.of(context)!.tryAgain,
                  style: AppStyles.login,),
              ),
            ],
          ),
        ),
      );
    }

    return Stack(
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
                  CarouselSlider.builder(
                    itemCount: movies.length,
                    itemBuilder:
                        (
                        BuildContext context,int itemIndex,int pageViewIndex,
                        ) => InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, AppRoute.moviesDetails, arguments: movies[itemIndex].id);
                          },
                          child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.yellowColor,
                            borderRadius: BorderRadius.circular(25),
                            image: DecorationImage(
                              image: NetworkImage(
                                movies[itemIndex].mediumCoverImage ?? '',
                              ),
                              fit: BoxFit.cover,
                              onError: (exception, stackTrace) {},
                            ),
                                                ),
                          ),
                        ),
                    options: CarouselOptions(
                      height: height * 0.40,
                      viewportFraction: 0.60,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      padEnds: true,
                      enableInfiniteScroll: true,
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
                        onPressed: widget.onSeeMore,
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
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoute.moviesDetails,
                                  arguments: actionMovies[index].id);
                            },
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Image.network(
                                    actionMovies[index].mediumCoverImage ?? '',
                                    fit: BoxFit.cover,
                                    loadingBuilder: (context, child, progress) {
                                      if (progress == null) return child;
                                      return Container(
                                        color: Colors.grey[900],
                                        child: const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, error, stack) =>
                                        Container(color: Colors.grey[800]),
                                  ),
                                ),
                                Positioned(
                                  top: height * 0.01,
                                  left: width * 0.01,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.01,
                                      vertical: height * 0.004,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.blackColor2,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          actionMovies[index].rating
                                              ?.toStringAsFixed(1) ?? '0',
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
                                )
                              ],
                            ),
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
    );
  }
}



