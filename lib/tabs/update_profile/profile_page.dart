import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moive_app/provider/user_provider.dart';
import 'package:moive_app/utils/app_colors.dart';
import 'package:moive_app/utils/app_images.dart';
import 'package:moive_app/utils/app_route.dart';
import 'package:moive_app/utils/app_styles.dart';
import 'package:moive_app/utils/dialog_utils.dart';
import 'package:moive_app/utils/screen_utils.dart';
import 'package:moive_app/view/widgets/custom_elevated_button.dart';
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
                const TabBar(
                  indicatorColor: Color(0xffffc107),
                  indicatorWeight: 5,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white,
                  tabs: [
                    Tab(
                      icon: Icon(
                        Icons.list,
                        color: Color(0xffffc107),
                        size: 38,
                      ),
                      text: 'Watch List',
                    ),
                    Tab(
                      icon: Icon(
                        Icons.folder,
                        color: Color(0xffffc107),
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

                      // Watch List
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                            AppImages.empty,
                              width: 180,
                            ),
                          ],
                        ),
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
