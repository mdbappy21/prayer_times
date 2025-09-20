import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:prayer_time/ui/utility/coordinates_cities.dart';
import 'package:prayers_times/prayers_times.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrayerController extends GetxController {
  final String location = 'Asia/Dhaka';
  var hijriDate = HijriCalendar.now();
  PrayerTimes? prayerTimes;
  String selectedCity = '';
  String selectedDivision = '';
  final String cityKey = 'selected_city_key';
  bool isLoading = false;

  @override
  Future<void> onInit() async {
    super.onInit();
    await initialize();
  }

  Future<void> loadCity() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    selectedCity = sharedPreferences.getString(cityKey) ?? 'Dhaka/Dhaka';
  }

  Future<void> saveCity({required String selectedValue}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(cityKey, selectedValue);
  }

  Future<void> initialize({String? division, String? city}) async {
    isLoading = true;
    update();
    if (division != null && city != null) {
      if (CoordinatesCities.divisions.containsKey(division) &&
          CoordinatesCities.divisions[division]!.containsKey(city)) {
        selectedCity = "$division/$city";
        await saveCity(selectedValue: selectedCity);
      }
    } else {
      await loadCity();
    }

    if (selectedCity.isEmpty) {
      selectedCity = 'Dhaka/Dhaka'; // final safeguard
    }

    final parts = selectedCity.split('/');
    selectedDivision = parts.first;
    final selectedCityName = parts.length > 1 ? parts.last : parts.first;

    Coordinates coordinates =
        CoordinatesCities.divisions[selectedDivision]?[selectedCityName] ??
            Coordinates(23.71153, 90.41115);

    PrayerCalculationParameters params = PrayerCalculationMethod.karachi();
    params.madhab = PrayerMadhab.hanafi;

    prayerTimes = PrayerTimes(
      coordinates: coordinates,
      calculationParameters: params,
      precision: true,
      locationName: location,
    );

    isLoading = false;
    update(); // ✅ only once, when prayerTimes is ready
  }

  Future<void> refreshPrayerTimes() async {
    await initialize(
      division: selectedDivision.isEmpty ? 'Dhaka' : selectedDivision,
      city: selectedCity.split('/').last,
    );
  }


  // helper
  String formatTime(DateTime? dt) {
    if (dt == null) return "Unknown";
    return DateFormat('hh:mm a').format(dt);
  }

  // fajr
  String get fajrStart => prayerTimes == null ? "Unknown" : formatTime(prayerTimes!.fajrStartTime);
  String get fajrEnd => prayerTimes == null ? "Unknown" : formatTime(prayerTimes!.fajrEndTime?.subtract(const Duration(minutes: 1)));

  // sunrise
  String get sunrise => prayerTimes == null ? "Unknown" : formatTime(prayerTimes!.sunrise);

  // ishraq (15 mins after sunrise)
  String get ishraqStart => prayerTimes == null ? "Unknown" : formatTime(prayerTimes!.sunrise?.add(const Duration(minutes: 15)));
  String get ishraqEnd => prayerTimes == null ? "Unknown" : formatTime(prayerTimes!.dhuhrStartTime?.subtract(const Duration(minutes: 5)));

  // dhuhr
  String get dhuhrStart => prayerTimes == null ? "Unknown" : formatTime(prayerTimes!.dhuhrStartTime);
  String get dhuhrEnd => prayerTimes == null ? "Unknown" : formatTime(prayerTimes!.dhuhrEndTime);

  // asr
  String get asrStart => prayerTimes == null ? "Unknown" : formatTime(prayerTimes!.asrStartTime);
  String get asrEnd => prayerTimes == null ? "Unknown" : formatTime(prayerTimes!.asrEndTime);

  // maghrib
  String get maghribStart => prayerTimes == null ? "Unknown" : formatTime(prayerTimes!.maghribStartTime);
  String get maghribEnd => prayerTimes == null ? "Unknown" : formatTime(prayerTimes!.maghribEndTime);

  // sunset (same as maghrib start)
  String get sunset => maghribStart;

  // isha
  String get ishaStart => prayerTimes == null ? "Unknown" : formatTime(prayerTimes!.ishaStartTime);
  String get ishaEnd => prayerTimes == null ? "Unknown" : formatTime(prayerTimes!.ishaEndTime);

  // midnight (fixed 12:00 AM)
  String get midNight => "12:00 AM";

  // current prayer
  String get currentPrayerName {
    if (prayerTimes == null) return "loading";
    final df = DateFormat("hh:mm a");
    final now = DateTime.now();

    final start = df.parse(ishraqStart);
    final end = df.parse(ishraqEnd);

    // merge with today's date
    final startToday = DateTime(now.year, now.month, now.day, start.hour, start.minute);
    final endToday = DateTime(now.year, now.month, now.day, end.hour, end.minute);

    if (now.isAfter(startToday) && now.isBefore(endToday)) {
      return 'ishraq';
    }else if(prayerTimes?.currentPrayer()=='ishabefore'){
      return 'isha';
    }
    final name = prayerTimes!.currentPrayer();
    return name;
  }

  DateTime get currentPrayerStartTime {
    final name = currentPrayerName;
    return prayerTimes?.timeForPrayer(name) ?? (name == 'ishaBefore' ? prayerTimes!.timeForPrayer('isha')! : (name=='ishraq')?prayerTimes!.timeForPrayer('sunrise')!.add(Duration(minutes: 15)):DateTime.now());
  }
  String get currentPrayerStart => formatTime(currentPrayerStartTime);
  String get currentPrayerEnd => currentEndTime(currentPrayerName);

  String currentEndTime(String prayerName) {
    if (prayerTimes == null) return "Unknown";

    switch (prayerName.toLowerCase()) {
      case "fajr":
        return formatTime(prayerTimes!.fajrEndTime);
      case "ishraq":
        return ishraqEnd;
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
