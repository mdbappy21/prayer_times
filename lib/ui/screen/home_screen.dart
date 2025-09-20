import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prayer_time/state_holders/date_controller.dart';
import 'package:prayer_time/state_holders/prayer_controller.dart';
import 'package:prayer_time/ui/widget/all_prayer_time.dart';
import 'package:prayer_time/ui/widget/background_image.dart';
import 'package:prayer_time/ui/widget/custom_app_bar.dart';
import 'package:prayer_time/ui/widget/custom_drawer.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateController dateController=Get.find<DateController>();
  PrayerController prayerController=Get.find<PrayerController>();
  Timer? _timer;
  
  bool _isDrawerOpen=false;
  void _toggleDrawer() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) async {
      await prayerController.refreshPrayerTimes();
      dateController.onRefresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade100,
      appBar: CustomAppBar(
        title: "Prayer Time",
        onMenuPressed: _toggleDrawer,
      ),
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
                  padding: EdgeInsets.only(left: 8, right: 8),
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
          CustomDrawer(
            isDrawerOpen: _isDrawerOpen,
            onToggleDrawer: _toggleDrawer,
          ),
        ],
      ),
    );
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

  Widget _currentPrayerInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32, top: 8, bottom: 16),
      child: Center(
        child: GetBuilder<PrayerController>(
          builder: (prayerController) {
            return Column(
              children: [
                Text("Current Prayer ",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text('${prayerController.currentPrayerName[0].toUpperCase()}${prayerController.currentPrayerName.substring(1)} ${prayerController.currentPrayerStart} ${prayerController.currentPrayerEnd}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            );
          }
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
