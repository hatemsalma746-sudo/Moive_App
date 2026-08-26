import 'package:flutter/material.dart';
import 'package:moive_app/l10n/app_localizations.dart';
import 'package:moive_app/provider/app_language_provider.dart';
import 'package:moive_app/utils/app_colors.dart';
import 'package:moive_app/utils/app_images.dart';
import 'package:moive_app/utils/app_styles.dart';
import 'package:moive_app/utils/screen_utils.dart';
import 'package:moive_app/view/widgets/change_avatar.dart';
import 'package:moive_app/view/widgets/custom_elevated_button.dart';
import 'package:moive_app/view/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

import '../../provider/user_provider.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  bool isGridLayout = false;
  int selectedAvatar = 0;

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
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    Provider.of<AppLanguageProvider>(context);
    final userProvider = context.watch<UserProvider>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.blackColor,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: AppColors.yellowColor),
        title: Text(
          AppLocalizations.of(context)!.pickAvatar,
          style: TextStyle(
            color: AppColors.yellowColor,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 16,
          ),
        ),
      ),
      backgroundColor: AppColors.blackColor,
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: height * 0.03,
          horizontal: width * 0.03,
        ),
        child: Column(
          spacing: height * 0.02,
          children: [
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: AppColors.greyColor,
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                      builder: (BuildContext context, setBottomSheetState) {
                        return ChangeAvatar(
                          avatars: avatars,
                          selectedAvatar: selectedAvatar,
                          onAvatarSelected: (index) {
                            setBottomSheetState(() {
                              selectedAvatar = index;
                            });
                            setState(() {
                              selectedAvatar = index;
                            });
                          },
                        );
                      },
                    );
                  },
                );
              },
              child: CircleAvatar(
                backgroundImage: AssetImage(userProvider.currentUser?.image ?? ''),
                maxRadius: height * 0.08,
              ),
            ),
            CustomTextField(
              borderColor: AppColors.greyColor,
              fillColor: AppColors.greyColor,
              hintText: userProvider.currentUser?.name ?? '',
              preIcon: Icon(Icons.person, color: AppColors.whiteColor),
              hintStyle: AppStyles.descriptions,
            ),
            CustomTextField(
              borderColor: AppColors.greyColor,
              fillColor: AppColors.greyColor,
              hintText: userProvider.currentUser?.phone ?? '',
              preIcon: Icon(Icons.phone, color: AppColors.whiteColor),
              hintStyle: AppStyles.descriptions,
            ),
            Align(
              alignment: AlignmentGeometry.centerStart,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  '${AppLocalizations.of(context)!.resetPassword} ',
                  style: AppStyles.descriptions,
                ),
              ),
            ),
            Expanded(child: SizedBox(height: height * 0.08)),
            CustomElevatedButton(
              onPressed: () {},
              backgroundColor: AppColors.redColor,
              foregroundColor: AppColors.blackColor,
              text: AppLocalizations.of(context)!.deleteAccount,
              borderColor: AppColors.redColor,
              textColor: AppColors.whiteColor,
            ),
            CustomElevatedButton(
              onPressed: () {},
              backgroundColor: AppColors.yellowColor,
              foregroundColor: AppColors.blackColor,
              text: AppLocalizations.of(context)!.updateDate,
              borderColor: AppColors.yellowColor,
              textColor: AppColors.blackColor,
            ),
          ],
        ),
      ),
    );
  }
}
