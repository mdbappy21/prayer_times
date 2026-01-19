import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prayer_time/ui/screen/important_rules.dart';
import 'package:prayer_time/ui/screen/qibla_compass_screen.dart';
import 'package:prayer_time/ui/utility/app_colors.dart';

class CustomDrawer extends StatelessWidget {
  final bool isDrawerOpen;
  final VoidCallback onToggleDrawer;

  const CustomDrawer({
    super.key,
    required this.isDrawerOpen,
    required this.onToggleDrawer,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        if (isDrawerOpen)
          GestureDetector(
            onTap: onToggleDrawer,
            child: Container(
              color: Colors.black.withValues(alpha: 0.6),
              width: double.infinity,
              height: double.infinity,
            ),
          ),

        if (isDrawerOpen)
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            width: size.width * .75,
            child: Container(
              color: AppColors.backgroundColor,
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: Text('Important Prayer Rules',style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),),
                    onTap: () {
                      onToggleDrawer();
                      Get.to(() => const ImportantRules());
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.explore_outlined),
                    title: Text('Qibla Compass',style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white)),
                    onTap: () {
                      onToggleDrawer();
                      Get.to(() => const QiblaCompassScreen());
                    },
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
