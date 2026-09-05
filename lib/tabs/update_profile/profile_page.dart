import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moive_app/model/firebase_model//favorite_services.dart';
import 'package:moive_app/model/movies_list/movies.dart';
import 'package:moive_app/provider/user_provider.dart';
import 'package:moive_app/services/movie_service.dart';
import 'package:moive_app/utils/app_colors.dart';
import 'package:moive_app/utils/app_images.dart';
import 'package:moive_app/utils/app_route.dart';
import 'package:moive_app/utils/app_styles.dart';
import 'package:moive_app/utils/dialog_utils.dart';
import 'package:moive_app/utils/screen_utils.dart';
import 'package:moive_app/view/widgets/custom_elevated_button.dart';
import 'package:moive_app/view/widgets/movie_card.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  Future<void> logout() async {
    try {
      DialogUtils.showLoading(context: context,
          text: 'Loading');
      await FirebaseAuth.instance.signOut();

      if (!context.mounted) return;

      DialogUtils.hideLoading(context: context);
      DialogUtils.showMessage(
          context: context,
          text: 'Logged out successfully',
          onPressed: (){
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoute.loginScreen,
                  (route) => false,
            );
          }
      );

    } catch (e) {
      DialogUtils.hideLoading(context: context);
      DialogUtils.showMessage(
          context: context,
          text: e.toString(),
          onPressed: (){
            Navigator.pop(context);
          });
      print('LOGOUT ERROR: $e');
    }
  }

  Future<List<Movies>> getFavoriteMovies() async {
    final ids = await FavoritesService.getFavorites();

    List<Movies> favoriteMovies = [];

    for (final id in ids) {
      try {
        final movie = await MovieService.fetchMovieById(id);
        favoriteMovies.add(movie);
      } catch (e) {
        print('ERROR GETTING MOVIE $id: $e');
      }
    }
    return favoriteMovies;
  }


  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    // var width = context.width;
    var height = context.height;
    return Scaffold(
      body: SafeArea(
          child: DefaultTabController(
            length: 2,
            child: Column(
              spacing: 15,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 15,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 10,
                        children: [
                          // todo: Avatar and Name
                          CircleAvatar(
                            backgroundImage: AssetImage(userProvider.currentUser?.image ?? ''),
                            maxRadius: height * 0.055,
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            userProvider.currentUser?.name ?? '',
                            style: AppStyles.bold20White,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        spacing: 10,
                        children: [
                          // todo: Wish List and number of wish movie
                          Text(
                            '20',
                            style: AppStyles.bold30White,
                          ),
                          Text(
                            'Wish List',
                            style: AppStyles.headers,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        spacing: 10,
                        children: [
                          // todo: History and number of history
                          Text(
                            '10',
                            style: AppStyles.bold30White,
                          ),
                          Text(
                            'History',
                            style: AppStyles.headers,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      flex: 2,
                        child: CustomElevatedButton(
                          onPressed: (){
                            Navigator.pushNamed(context, AppRoute.updateProfileScreen);
                          },
                            backgroundColor: AppColors.yellowColor,
                            foregroundColor: AppColors.blackColor,
                            text: 'Edit Profile',
                            borderColor: AppColors.yellowColor,
                            textColor: AppColors.blackColor
                        ),
                    ),
                    Expanded(
                      flex: 1,
                      child: CustomElevatedButton(
                          onPressed: (){
                            logout();
                          },
                          backgroundColor: AppColors.redColor,
                          foregroundColor: AppColors.whiteColor,
                          text: 'Exit',
                          borderColor: AppColors.redColor,
                          textColor: AppColors.whiteColor,
                        isImage: true,
                        iconImage: AssetImage(AppImages.exitIcon),
                      ),
                    )
                  ],
                ),
                TabBar(
                  indicatorColor: AppColors.yellowColor,
                  indicatorWeight: 5,
                  labelColor: AppColors.whiteColor,
                  unselectedLabelColor: AppColors.whiteColor,
                  tabs: [
                    Tab(
                      icon: Icon(
                        Icons.list,
                        color: AppColors.yellowColor,
                        size: 38,
                      ),
                      text: 'Watch List',
                    ),
                    Tab(
                      icon: Icon(
                        Icons.folder,
                        color: AppColors.yellowColor,
                        size: 38,
                      ),
                      text: 'History',
                    ),
                  ],
                ),

                // ================= TAB CONTENT =================

                Expanded(
                  child: TabBarView(
                    children: [
                      FutureBuilder<List<Movies>>(
                        future: getFavoriteMovies(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: AppColors.yellowColor,
                              ),
                            );
                          }

                          if (snapshot.hasError) {
                            print('WATCHLIST ERROR: ${snapshot.error}');

                            return Center(
                              child: Text(
                                'Something went wrong',
                                style: AppStyles.bold20White,
                              ),
                            );
                          }

                          final favoriteMovies = snapshot.data ?? [];

                          if (favoriteMovies.isEmpty) {
                            return Center(
                              child: Image.asset(
                                AppImages.empty,
                                width: 180,
                              ),
                            );
                          }

                          return GridView.builder(
                            padding: const EdgeInsets.all(10),
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.65,
                            ),
                            itemCount: favoriteMovies.length,
                            itemBuilder: (context, index) {
                              return MovieCard(
                                movie: favoriteMovies[index],
                              );
                            },
                          );
                        },
                      ),

                      // History
                      const Center(
                        child: Text(
                          'History',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}
