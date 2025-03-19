import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:prayer_time/ui/utility/app_colors.dart';
import 'package:prayer_time/ui/utility/gregorian_date.dart';
import 'package:prayer_time/ui/utility/prayer_time.dart';
import 'package:prayer_time/ui/widget/background_image.dart';
import 'package:prayer_time/ui/utility/hijri_date.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String hijriDate='${HijriDate.date} ${HijriDate.monthName} ${HijriDate.year} Hijri';
  String gregorianDate='${GregorianDate.dayName} ${GregorianDate.day} ${GregorianDate.monthName} ${GregorianDate.year}';
  String formatted=GregorianDate.formattedTime;
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
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
        leading: IconButton(
          icon:Icon(Icons.menu),
          onPressed: _toggleDrawer,
          color: AppColors.themeColor,
        ),
        title: Text(
          "Dhaka",
          style: TextStyle(color: AppColors.themeColor),
        ),
        actions: [Icon(Icons.more_vert, color: AppColors.themeColor)],
      ),
      body: Stack(
        children: [
          BackgroundWidget(
            child: RefreshIndicator(
              onRefresh: _updateDateTime,
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
                            Text('${_currentPrayerNameCorrection()} ${PrayerTime.currentPrayerStart} ${PrayerTime.currentEnd}',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                    _buildPrayerTime()
                  ],
                ),
              ),
            ),
          ),
          Stack(
            children: [
              // GestureDetector to detect taps outside the drawer
              if (_isDrawerOpen)
                GestureDetector(
                  onTap: _toggleDrawer, // Close the drawer when tapping outside
                  child: Container(
                    color: Colors.black.withOpacity(0.5), // Optional: Adds a semi-transparent overlay
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
      //GregorianDate update
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
      DateTime midNightOfADay = HijriDate.timeToDateTime(PrayerTime.midNight);//midnight
      DateTime ifterTime = HijriDate.timeToDateTime(PrayerTime.magribStart);//magribStart
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
    if(PrayerTime.currentPrayerName=='ishabefore'){
      return 'Isha';
    }
    else {
      return '${PrayerTime.currentPrayerName[0].toUpperCase()}${PrayerTime.currentPrayerName.substring(1)}';
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

  Widget _buildPrayerTime() {
    return Expanded(
      child: SingleChildScrollView(
        child: Card(
          color: Colors.transparent,
          child: Column(
            children: [
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text("Sahri End",
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                  Expanded(
                      flex: 2,
                      child: Text(PrayerTime.ishaEnd,
                          style: Theme.of(context).textTheme.titleMedium)),
                  Expanded(flex: 1, child: Icon(Icons.alarm))
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text("Fajr Start",
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                  Expanded(
                      flex: 2,
                      child: Text(PrayerTime.fajrStart,
                          style: Theme.of(context).textTheme.titleMedium)),
                  Expanded(flex: 1, child: Icon(Icons.alarm))
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text("Fajr End",
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                  Expanded(
                      flex: 2,
                      child: Text(PrayerTime.fajrEnd,
                          style: Theme.of(context).textTheme.titleMedium)),
                  Expanded(flex: 1, child: Icon(Icons.alarm))
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text("Sunrise Start",
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                  Expanded(
                      flex: 2,
                      child: Text(PrayerTime.sunriseStart,
                          style: Theme.of(context).textTheme.titleMedium)),
                  Expanded(flex: 1, child: Icon(Icons.alarm))
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text("Ishraq Start",
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                  Expanded(
                      flex: 2,
                      child: Text(PrayerTime.ishraqStart,
                          style: Theme.of(context).textTheme.titleMedium)),
                  Expanded(flex: 1, child: Icon(Icons.alarm))
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text("Dhuhr Start",
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                  Expanded(
                      flex: 2,
                      child: Text(PrayerTime.dhuhrStart,
                          style: Theme.of(context).textTheme.titleMedium)),
                  Expanded(flex: 1, child: Icon(Icons.alarm))
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text("Dhuhr End",
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                  Expanded(
                      flex: 2,
                      child: Text(PrayerTime.dhuhrEnd,
                          style: Theme.of(context).textTheme.titleMedium)),
                  Expanded(flex: 1, child: Icon(Icons.alarm))
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text("Asr Start",
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                  Expanded(
                      flex: 2,
                      child: Text(PrayerTime.asrStart,
                          style: Theme.of(context).textTheme.titleMedium)),
                  Expanded(flex: 1, child: Icon(Icons.alarm))
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text("Asr End",
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                  Expanded(
                      flex: 2,
                      child: Text(PrayerTime.asrEnd,
                          style: Theme.of(context).textTheme.titleMedium)),
                  Expanded(flex: 1, child: Icon(Icons.alarm))
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text("Sunset",
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                  Expanded(
                      flex: 2,
                      child: Text(PrayerTime.sunset,
                          style: Theme.of(context).textTheme.titleMedium)),
                  Expanded(flex: 1, child: Icon(Icons.alarm))
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text("Magrib / Ifter",
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                  Expanded(
                      flex: 2,
                      child: Text(PrayerTime.magribStart,
                          style: Theme.of(context).textTheme.titleMedium)),
                  Expanded(flex: 1, child: Icon(Icons.alarm))
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text("Magrib End",
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                  Expanded(
                      flex: 2,
                      child: Text(PrayerTime.magribEnd,
                          style: Theme.of(context).textTheme.titleMedium)),
                  Expanded(flex: 1, child: Icon(Icons.alarm))
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text("Isha Start",
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                  Expanded(
                      flex: 2,
                      child: Text(PrayerTime.ishaStart,
                          style: Theme.of(context).textTheme.titleMedium)),
                  Expanded(flex: 1, child: Icon(Icons.alarm))
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text("Isha End",
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                  Expanded(
                      flex: 2,
                      child: Text(PrayerTime.ishaEnd,
                          style: Theme.of(context).textTheme.titleMedium)),
                  Expanded(flex: 1, child: Icon(Icons.alarm))
                ],
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

}
