import 'package:flutter/material.dart';
import 'package:moive_app/utils/app_colors.dart';
import 'package:moive_app/utils/screen_utils.dart';

class ChangeAvatar extends StatelessWidget {
  final List<String> avatars;
  final int selectedAvatar;
  final Function(int) onAvatarSelected;

  const ChangeAvatar({
    super.key,
    required this.avatars,
    required this.selectedAvatar,
    required this.onAvatarSelected,
  });

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: width * 0.04,
        mainAxisSpacing: height * 0.01,
      ),
      itemCount: avatars.length,
      itemBuilder: (context, index) {
        final bool isSelected = selectedAvatar == index;
        return GestureDetector(
          onTap: () {
            onAvatarSelected(index);
          },
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.selectedAvatarColor
                  : AppColors.transparentColor,
              border: Border.all(color: AppColors.yellowColor),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Image.asset(avatars[index]),
          ),
        );
      },
    );
  }
}
