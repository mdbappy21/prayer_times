import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prayer_time/state_holders/date_controller.dart';
import 'package:prayer_time/state_holders/prayer_controller.dart';
import 'package:prayer_time/ui/utility/app_colors.dart';
import 'package:prayer_time/ui/widget/all_prayer_time.dart';
import 'package:prayer_time/ui/widget/background_image.dart';
import 'package:prayer_time/ui/widget/city_picker_dialog.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateController dateController=Get.find<DateController>();
  PrayerController prayerController=Get.find<PrayerController>();

  bool _isDrawerOpen=false;
  void _toggleDrawer() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade100,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          BackgroundWidget(
            child: RefreshIndicator(
              onRefresh: () async {
                await prayerController.refreshPrayerTimes();
                dateController.onRefresh();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.only(left: 8,right: 8),
                  child: Column(
                    children: [
                      _buildHijriGregorianDate(context),
                      _currentPrayerInfo(context),
                      AllPrayerTime(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          _buildDrawer(context)
        ],
      ),
    );
  }

  Widget _currentPrayerInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32, top: 8, bottom: 16),
      child: Center(
        child: Column(
          children: [
            Text("Current Prayer ",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text('${_currentPrayerNameCorrection()} ${prayerController.currentPrayerStart} ${prayerController.currentPrayerEnd}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Stack(
      children: [
        if (_isDrawerOpen)
          GestureDetector(
            onTap: _toggleDrawer,
            child: Container(
              color: Colors.black.withValues(alpha: 0.6),
              width: double.infinity,
              height: double.infinity,
            ),
          ),

        // Drawer
        if (_isDrawerOpen)
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            width: 250,
            // Drawer width
            child: Container(
              color: AppColors.backgroundColor,
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Al-Quran',
                        style: Theme.of(context).textTheme.titleMedium),
                    onTap: _toggleDrawer, // Close the drawer
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Kebla Campus',
                        style: Theme.of(context).textTheme.titleMedium),
                    onTap: _toggleDrawer, // Close the drawer
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Dua',
                        style: Theme.of(context).textTheme.titleMedium),
                    onTap: _toggleDrawer, // Close the drawer
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Prayer Education',
                        style: Theme.of(context).textTheme.titleMedium),
                    onTap: _toggleDrawer, // Close the drawer
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Important Date',
                        style: Theme.of(context).textTheme.titleMedium),
                    onTap: _toggleDrawer, // Close the drawer
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  String _currentPrayerNameCorrection(){
    if(prayerController.currentPrayerName=='ishabefore'){
      return 'Isha';
    }
    else {
      return '${prayerController.currentPrayerName[0].toUpperCase()}${prayerController.currentPrayerName.substring(1)}';
    }
  }

  Widget _buildHijriGregorianDate(BuildContext context) {
    return GetBuilder<DateController>(
      builder: (dateController) {
        return Card(
          borderOnForeground: true,
          color: Colors.transparent,
          child: ListTile(
            title: Center(
              child: Column(
                children: [
                  Text('${dateController.hijriDay} ${dateController.hijriMonth} ${dateController.hijriYear} Hijri', style: Theme.of(context).textTheme.titleMedium),
                  Text('${dateController.gregorianDayName}, ${dateController.gregorianDay} ${dateController.gregorianMonthName} ${dateController.gregorianYear}',style: Theme.of(context).textTheme.titleMedium,),
                  Text(dateController.formattedTime, style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      centerTitle: true,
      leading: IconButton(
        icon:Icon(Icons.menu),
        onPressed: _toggleDrawer,
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

      actions: [Icon(Icons.more_vert, color: AppColors.themeColor)],
    );
  }

}
