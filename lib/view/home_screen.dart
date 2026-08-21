import 'package:flutter/material.dart';
import 'package:moive_app/tabs/explore/explore_page.dart';
import 'package:moive_app/tabs/home/main_page.dart';
import 'package:moive_app/tabs/search/search_page.dart';
import 'package:moive_app/tabs/update_profile/update_profile_screen.dart';
import 'package:moive_app/utils/app_colors.dart';
import 'package:moive_app/utils/app_images.dart';
import 'package:moive_app/utils/screen_utils.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> tabsList = [
    MainPage(), SearchPage(), ExplorePage(), UpdateProfileScreen(),
  ];
  List<Widget>movies = [
    Image.asset(AppImages.blackPanther,),
    Image.asset(AppImages.doctorStrange,),
    Image.asset(AppImages.moive1917,),
    Image.asset(AppImages.captainAmerica),
    Image.asset(AppImages.avengers,),
  ];

  @override
  Widget build(BuildContext context) {
    double height = context.height;
    double width = context.width;
    return Scaffold(
        backgroundColor: AppColors.blackColor,
        bottomNavigationBar:
        Padding(
          padding: EdgeInsets.fromLTRB(
              width * 0.04, 0, width * 0.04, height * 0.01),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BottomNavigationBar(
                selectedItemColor: AppColors.yellowColor,
                unselectedItemColor: AppColors.whiteColor,
                currentIndex: selectedIndex,
                onTap: (index) {
                  selectedIndex = index;
                  setState(() {

                  });
                },
                type: BottomNavigationBarType.fixed,
                backgroundColor: AppColors.greyColor,
                items: [
                  BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage(AppImages.homeIcon)),
                    label: "",),
                  BottomNavigationBarItem(
                      icon: ImageIcon(AssetImage(AppImages.searchIcon)),
                      label: ""),
                  BottomNavigationBarItem(
                      icon: ImageIcon(AssetImage(AppImages.exploreIcon)),
                      label: ""),
                  BottomNavigationBarItem(

                      icon: ImageIcon(AssetImage(AppImages.profileIcon)),
                      label: ""),
                ]),
          ),
        ),

        body: tabsList[selectedIndex]
    );
  }
}
