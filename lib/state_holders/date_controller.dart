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

  DateTime _timeToDateTime(String time) {
    final format = DateFormat("h:mm a");
    return format.parse(time);
  }

  int get hijriDay {
    final prayerController = Get.find<PrayerController>();

    final midNight = _timeToDateTime(prayerController.midNight);
    final maghribStart = _timeToDateTime(prayerController.maghribStart);
    final now = DateTime.now();
    final currentTime = _timeToDateTime(DateFormat('hh:mm a').format(now));

    if (currentTime.isAfter(midNight) && currentTime.isBefore(maghribStart)) {
      return hijriDate.hDay - 1;
    } else {
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

  void _updateGregorian() {
    currentDateTime = DateTime.now();
  }
}
