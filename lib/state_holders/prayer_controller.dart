import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:prayer_time/ui/utility/coordinates_cities.dart';
import 'package:prayers_times/prayers_times.dart';
import 'package:intl/intl.dart';

class PrayerController extends GetxController {
  final String location = 'Asia/Dhaka';
  var hijriDate = HijriCalendar.now();
  PrayerTimes? prayerTimes;
  String selectedCity = 'Dhaka/Dhaka';
  String selectedDivision='';

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  void initialize({String? division, String? city}) {
    if (division != null && city != null) {
      if (CoordinatesCities.divisions.containsKey(division) &&
          CoordinatesCities.divisions[division]!.containsKey(city)) {
        selectedCity = "$division/$city";
      }
    }
    final parts = selectedCity.split('/');
    selectedDivision = parts[0];
    final selectedCityName = parts.length > 1 ? parts[1] : parts[0];

    Coordinates? coordinates =
    CoordinatesCities.divisions[selectedDivision]?[selectedCityName];
    if (coordinates == null) {
      return;
    }

    PrayerCalculationParameters params = PrayerCalculationMethod.karachi();
    params.madhab = PrayerMadhab.hanafi;
    prayerTimes = PrayerTimes(
      coordinates: coordinates,
      calculationParameters: params,
      precision: true,
      locationName: location,
    );
    update();

  }

  Future<void> refreshPrayerTimes() async {
    initialize(
      division: selectedDivision.split('/').first,
      city: selectedCity.split('/').last,
    );
    update(); // notify listeners
  }

  // helper
  String formatTime(DateTime? dt) {
    if (dt == null) return "Failed";
    return DateFormat('hh:mm a').format(dt);
  }

  // fajr
  String get fajrStart => prayerTimes == null ? "Failed" : formatTime(prayerTimes!.fajrStartTime);
  String get fajrEnd => prayerTimes == null ? "Failed" : formatTime(prayerTimes!.fajrEndTime?.subtract(const Duration(minutes: 1)));

  // sunrise
  String get sunrise => prayerTimes == null ? "Failed" : formatTime(prayerTimes!.sunrise);

  // ishraq (15 mins after sunrise)
  String get ishraq => prayerTimes == null ? "Failed" : formatTime(prayerTimes!.sunrise?.add(const Duration(minutes: 15)));

  // dhuhr
  String get dhuhrStart => prayerTimes == null ? "Failed" : formatTime(prayerTimes!.dhuhrStartTime);
  String get dhuhrEnd => prayerTimes == null ? "Failed" : formatTime(prayerTimes!.dhuhrEndTime);

  // asr
  String get asrStart => prayerTimes == null ? "Failed" : formatTime(prayerTimes!.asrStartTime);
  String get asrEnd => prayerTimes == null ? "Failed" : formatTime(prayerTimes!.asrEndTime);

  // maghrib
  String get maghribStart => prayerTimes == null ? "Failed" : formatTime(prayerTimes!.maghribStartTime);
  String get maghribEnd => prayerTimes == null ? "Failed" : formatTime(prayerTimes!.maghribEndTime);

  // sunset (same as maghrib start)
  String get sunset => maghribStart;

  // isha
  String get ishaStart => prayerTimes == null ? "Failed" : formatTime(prayerTimes!.ishaStartTime);
  String get ishaEnd => prayerTimes == null ? "Failed" : formatTime(prayerTimes!.ishaEndTime);

  // midnight (fixed 12:00 AM)
  String get midNight => "12:00 AM";

  // current prayer
  String get currentPrayerName => prayerTimes?.currentPrayer() ?? "Unknown";
  DateTime get currentPrayerStartTime {
    final name = currentPrayerName;
    return prayerTimes?.timeForPrayer(name) ?? (name == 'ishaBefore' ? DateTime.now() : DateTime.now());
  }
  String get currentPrayerStart => formatTime(currentPrayerStartTime);
  String get currentPrayerEnd => currentEndTime(currentPrayerName);


  String get currentPrayer {
    if (prayerTimes == null) return "Failed";
    final name = prayerTimes!.currentPrayer();
    final start = prayerTimes!.timeForPrayer(name);
    return "$name - ${formatTime(start)}";
  }

  String currentEndTime(String prayerName) {
    if (prayerTimes == null) return "Failed";

    switch (prayerName.toLowerCase()) {
      case "fajr":
        return formatTime(prayerTimes!.fajrEndTime);
      case "dhuhr":
        return formatTime(prayerTimes!.dhuhrEndTime);
      case "asr":
        return formatTime(prayerTimes!.asrEndTime);
      case "maghrib":
        return formatTime(prayerTimes!.maghribEndTime);
      case "isha":
        return formatTime(prayerTimes!.ishaEndTime);
      case "sunrise":
        return formatTime(prayerTimes!.sunrise);
      case "ishabefore":
        return formatTime(prayerTimes!.ishaEndTime);
      default:
        return "Unknown";
    }
  }
}
