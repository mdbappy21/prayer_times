import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prayer_time/state_holders/prayer_controller.dart';
import 'package:prayer_time/ui/utility/app_colors.dart';
import 'package:prayer_time/ui/widget/city_picker_dialog.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onMenuPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      centerTitle: true,
      leading: IconButton(
        icon:Icon(Icons.menu),
        onPressed: onMenuPressed,
        color: AppColors.themeColor,
      ),

      title: GetBuilder<PrayerController>(
        builder: (prayerController) {
          return GestureDetector(
            onTap: (){
              showCityPickerDialog(context);
            },
            child: Text(
              prayerController.selectedCity.split('/').last,
              style: TextStyle(color: AppColors.themeColor),
            ),
          );
        },
      ),

    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
