import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:prayer_time/ui/utility/prayer_time.dart';

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
    DateTime midNightOfADay =
        HijriDate.timeToDateTime(PrayerTime.midNight); //midnight
    DateTime ifterTime =
        HijriDate.timeToDateTime(PrayerTime.magribStart); //magribStart
    DateTime currentTime = HijriDate.timeToDateTime(formattedTime); //current

    if (currentTime.isAfter(midNightOfADay) &&
        currentTime.isBefore(ifterTime)) {
      return dateW -= 1;
    } else {
      return dateW;
    }
  }
}
