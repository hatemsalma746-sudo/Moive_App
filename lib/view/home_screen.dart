import 'package:flutter/material.dart';
import 'package:moive_app/tabs/explore/explore_page.dart';
import 'package:moive_app/tabs/home/main_page.dart';
import 'package:moive_app/tabs/search/search_page.dart';
import 'package:moive_app/tabs/update_profile/profile_page.dart';
import 'package:moive_app/utils/app_colors.dart';
import 'package:moive_app/utils/app_images.dart';
import 'package:moive_app/utils/screen_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int selectedIndex = 0;
  String? selectedGenre;
  List<Widget> tabsList = [];

  @override
  void initState() {
    super.initState();

    tabsList = [
      MainPage(
        onSeeMore: () {
          setState(() {
            selectedGenre = 'Action';
            selectedIndex = 2;
          });
        },
      ),
      SearchPage(),
      ExplorePage(),
      ProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {

    double height = context.height;
    double width = context.width;
    return Scaffold(
        backgroundColor: AppColors.blackColor,
        bottomNavigationBar:
        Padding(
          padding: EdgeInsets.only(
            right: width * 0.021,
            left: width * 0.021,
            bottom: height * 0.04,
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
            child: BottomNavigationBar(
              selectedItemColor: AppColors.yellowColor,
              unselectedItemColor: AppColors.whiteColor,
              currentIndex: selectedIndex,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppColors.greyColor,

              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },

              items: [
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(AppImages.homeIcon),
                    size: 28,
                  ),
                  label: '',
                ),

                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(AppImages.searchIcon),
                    size: 28,
                  ),
                  label: '',
                ),

                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(AppImages.exploreIcon),
                    size: 28,
                  ),
                  label: ''
                ),

                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(AppImages.profileIcon),
                    size: 28,
                  ),
                  label: '',
                ),
              ],
            ),
          )
        ),

        body: tabsList[selectedIndex]
    );
  }

}
