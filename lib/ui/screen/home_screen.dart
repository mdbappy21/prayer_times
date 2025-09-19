import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:prayer_time/state_holders/prayer_controller.dart';
import 'package:prayer_time/ui/utility/app_colors.dart';
import 'package:prayer_time/ui/utility/coordinates_cities.dart';
import 'package:prayer_time/ui/utility/gregorian_date.dart';
import 'package:prayer_time/ui/widget/all_prayer_time.dart';
import 'package:prayer_time/ui/widget/background_image.dart';
import 'package:prayer_time/ui/utility/hijri_date.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String hijriDate='${HijriDate.date} ${HijriDate.monthName} ${HijriDate.year} Hijri';
  String gregorianDate='${GregorianDate.dayName} ${GregorianDate.day} ${GregorianDate.monthName} ${GregorianDate.year}';
  String formatted=GregorianDate.formattedTime;
  bool _isDrawerOpen=false;
  PrayerController prayerController=Get.find<PrayerController>();
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
                await _updateDateTime(); // update dates
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.only(left: 8,right: 8),
                  child: Column(
                    children: [
                      _buildHijriGregorianDate(context),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 32, right: 32,top: 8, bottom: 16),
                        child: Center(
                          child: Column(
                            children: [
                              Text("Current Prayer ",style: Theme.of(context).textTheme.titleMedium),
                              Text('${_currentPrayerNameCorrection()} ${prayerController.currentPrayerStart} ${prayerController.currentPrayerEnd}',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // _buildPrayerTime()
                      AllPrayerTime(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Stack(
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
                  width: 250, // Drawer width
                  child: Container(
                    color: AppColors.backgroundColor,
                    child: ListView(
                      children: [
                        ListTile(
                          leading: Icon(Icons.home),
                          title: Text('Al-Quran', style: Theme.of(context).textTheme.titleMedium),
                          onTap: _toggleDrawer, // Close the drawer
                        ),
                        ListTile(
                          leading: Icon(Icons.settings),
                          title: Text('Kebla Campus', style: Theme.of(context).textTheme.titleMedium),
                          onTap: _toggleDrawer, // Close the drawer
                        ),
                        ListTile(
                          leading: Icon(Icons.settings),
                          title: Text('Dua', style: Theme.of(context).textTheme.titleMedium),
                          onTap: _toggleDrawer, // Close the drawer
                        ),
                        ListTile(
                          leading: Icon(Icons.settings),
                          title: Text('Prayer Education', style: Theme.of(context).textTheme.titleMedium),
                          onTap: _toggleDrawer, // Close the drawer
                        ),
                        ListTile(
                          leading: Icon(Icons.settings),
                          title: Text('Important Date', style: Theme.of(context).textTheme.titleMedium),
                          onTap: _toggleDrawer, // Close the drawer
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> _updateDateTime() async {
    setState(() {
      DateTime currentDateTime=DateTime.now();
      String dayName = DateFormat('EEEE').format(currentDateTime);
      String monthName = DateFormat('MMMM').format(currentDateTime);
      String day = DateFormat('d').format(currentDateTime);
      String year = DateFormat('y').format(currentDateTime);
      String formattedTime = DateFormat('hh:mm a').format(currentDateTime);

      //hijri date update
       var currentHijri = HijriCalendar.now();
       int hijriYear=currentHijri.hYear;
       String hijriMonthName=currentHijri.longMonthName;
      int currentHijriDate=currentHijri.hDay;
      //
      DateTime midNightOfADay = HijriDate.timeToDateTime(prayerController.midNight);//midnight
      DateTime ifterTime = HijriDate.timeToDateTime(prayerController.maghribStart);//magribStart
      DateTime currentTime = HijriDate.timeToDateTime(formattedTime);//current
      //
      if (currentTime.isAfter(midNightOfADay) && currentTime.isBefore(ifterTime)){
        currentHijriDate-=1;
      }else{
        currentHijriDate;
      }

      //update status
      hijriDate = '$currentHijriDate $hijriMonthName $hijriYear Hijri';
      gregorianDate = '$dayName $day $monthName $year';
      formatted = formattedTime;
    });
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
    return Card(
      borderOnForeground: true,
      color: Colors.transparent,
      child: ListTile(
        title: Center(
          child: Column(
            children: [
              Text(hijriDate, style: Theme.of(context).textTheme.titleMedium),
              Text(gregorianDate,style: Theme.of(context).textTheme.titleMedium,),
              Text(formatted, style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
      ),
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
            onTap: _chooseCities,
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

  void _chooseCities() {
    final PrayerController controller = Get.find<PrayerController>();
    String? selectedDivision;
    bool isDivisionSelected = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            // Determine title and list to show
            final title = isDivisionSelected ? selectedDivision! : "Choose Division";
            final listItems = isDivisionSelected ? CoordinatesCities.divisions[selectedDivision!]!.keys.toList() : CoordinatesCities.divisions.keys.toList();

            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green.shade400, Colors.green.shade900],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12), // optional
                ),
                // padding: const EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width * 0.8,
                height: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity, // full width
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.green.shade400, Colors.green.shade900],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)), // optional
                      ),
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // text color
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: ListView.builder(
                        itemCount: listItems.length,
                        itemBuilder: (context, index) {
                          final item = listItems[index];
                          return ListTile(
                            title: Text(item),
                            onTap: () {
                              if (!isDivisionSelected) {
                                // Division tapped
                                setState(() {
                                  selectedDivision = item;
                                  isDivisionSelected = true;
                                });
                              } else {
                                // City tapped
                                controller.initialize(
                                  division: selectedDivision!,
                                  city: item,
                                );
                                Get.back();
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
