import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:prayer_time/state_holders/prayer_controller.dart';

class DateController extends GetxController {
  var hijriDate = HijriCalendar.now();
  late int hijriYear;
  late String hijriMonth;

  DateTime currentDateTime = DateTime.now();

  @override
  void onInit() {
    super.onInit();
    _updateHijri();
    _updateGregorian();
  }

  DateTime? _timeToDateTime(String time) {
    if (time.isEmpty || time == "Unknown" || time == "Failed") return null;
    try {
      final format = DateFormat("h:mm a");
      return format.parse(time);
    } catch (e) {
      return null;
    }
  }


  int get hijriDay {
    final prayerController = Get.find<PrayerController>();

    final midNight = _timeToDateTime(prayerController.midNight);
    final maghribStart = _timeToDateTime(prayerController.isLoading?'06:00 PM':prayerController.maghribStart);
    final now = DateTime.now();
    final currentTime = _timeToDateTime(DateFormat('hh:mm a').format(now));
    if (midNight == null || maghribStart == null || currentTime == null) {
      return hijriDate.hDay;
    }
    if (currentTime.isAfter(midNight) && currentTime.isBefore(maghribStart)) {
      if (hijriDate.hDay - 1 == 0) {

        int prevMonth = hijriDate.hMonth - 1;
        int prevYear = hijriDate.hYear;

        if (prevMonth == 0) {
          prevMonth = 12;
          prevYear -= 1;
        }

        final temp = HijriCalendar()
          ..hYear = prevYear
          ..hMonth = prevMonth
          ..hDay = 1;

        final lastDayOfPrevMonth =
        temp.getDaysInMonth(prevYear, prevMonth);

        _setPreviousHijriMonthByValues(prevYear, prevMonth);

        return lastDayOfPrevMonth;
      }
      else {
          return hijriDate.hDay - 1;
        }
    }
    else {
      return hijriDate.hDay;
    }
  }

  String get gregorianDayName => DateFormat('EEEE').format(currentDateTime);
  String get gregorianMonthName => DateFormat('MMMM').format(currentDateTime);
  String get gregorianDay => DateFormat('d').format(currentDateTime);
  String get gregorianYear => DateFormat('y').format(currentDateTime);
  String get formattedTime => DateFormat('hh:mm a').format(currentDateTime);


  void onRefresh() {
    _updateHijri();
    _updateGregorian();
    update();
  }

  void _updateHijri() {
    hijriDate = HijriCalendar.now();
    hijriYear = hijriDate.hYear;
    hijriMonth = hijriDate.longMonthName;
  }

  void _setPreviousHijriMonthByValues(int year, int month) {
    hijriYear = year;

    final temp = HijriCalendar()
      ..hYear = year
      ..hMonth = month
      ..hDay = 1;

    hijriMonth = temp.getLongMonthName();
  }

  void _updateGregorian() {
    currentDateTime = DateTime.now();
  }
}
