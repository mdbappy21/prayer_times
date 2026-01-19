import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:prayer_time/state_holders/prayer_controller.dart';

class HijriDate {
  static var hijriDate = HijriCalendar.now();
  static int year = hijriDate.hYear;
  static String monthName = hijriDate.longMonthName;

  static DateTime timeToDateTime(String time) {
    final format = DateFormat("h:mm a");
    return format.parse(time);
  }

  static DateTime currentDateTime = DateTime.now();
  static String formattedTime = DateFormat('hh:mm a').format(currentDateTime);
  static int dateW = hijriDate.hDay;
  static int date = dateCorrect();

  static int dateCorrect() {
    PrayerController prayerController=Get.find<PrayerController>();
    DateTime midNightOfADay =
        HijriDate.timeToDateTime(prayerController.midNight); //midnight
    DateTime ifterTime =
        HijriDate.timeToDateTime(prayerController.maghribStart); //magribStart
    DateTime currentTime = HijriDate.timeToDateTime(formattedTime); //current

    if (currentTime.isAfter(midNightOfADay) &&
        currentTime.isBefore(ifterTime)) {
      return dateW -= 1;
    } else {
      return dateW;
    }
  }
}
