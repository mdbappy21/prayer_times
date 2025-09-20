import 'package:flutter/material.dart';
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
            width: 250, // Drawer width
            child: Container(
              color: AppColors.backgroundColor,
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: Text('Al-Quran',
                        style: Theme.of(context).textTheme.titleMedium),
                    onTap: onToggleDrawer,
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: Text('Kebla Campus',
                        style: Theme.of(context).textTheme.titleMedium),
                    onTap: onToggleDrawer,
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: Text('Dua',
                        style: Theme.of(context).textTheme.titleMedium),
                    onTap: onToggleDrawer,
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: Text('Prayer Education',
                        style: Theme.of(context).textTheme.titleMedium),
                    onTap: onToggleDrawer,
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: Text('Important Date',
                        style: Theme.of(context).textTheme.titleMedium),
                    onTap: onToggleDrawer,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
