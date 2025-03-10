import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:prayers_times/prayers_times.dart';

final String location = 'Asia/Dhaka';
class PrayerTime {
  static var hijriDate = HijriCalendar.now();
  static PrayerTimes? prayerTimes;

  static void initialize() {
    Coordinates coordinates = Coordinates(23.6850, 90.3563); // Dhaka
    PrayerCalculationParameters params = PrayerCalculationMethod.karachi();
    params.madhab = PrayerMadhab.hanafi;
    prayerTimes = PrayerTimes(
      coordinates: coordinates,
      calculationParameters: params,
      precision: true,
      locationName: location,
    );
  }

  //Fajr Start Time
  static String get fajrStartTime {
    if (prayerTimes != null) {
      return prayerTimes!.fajrStartTime.toString();
    } else {
      return 'Failed to get';
    }
  }

  static DateTime fajrStartDateTime = DateTime.parse(fajrStartTime);
  static String fajrStart = formatTime(fajrStartDateTime);

  //Fajr End Time
  static String get fajrEndTime {
    if (prayerTimes != null) {
      return prayerTimes!.fajrEndTime.toString();
    } else {
      return 'Failed to get';
    }
  }

  static DateTime fajrEndDateTime = DateTime.parse(fajrEndTime);
  static DateTime fajrEndDateTimeReduce = fajrEndDateTime.subtract(Duration(minutes: 1));
  static String fajrEnd = formatTime(fajrEndDateTimeReduce);

  //Sunrise start
  static String get sunrise {
    if (prayerTimes != null) {
      return prayerTimes!.sunrise.toString();
    } else {
      return 'Failed to get';
    }
  }

  static DateTime sunriseDateTime = DateTime.parse(sunrise);
  static String sunriseStart = formatTime(sunriseDateTime);

  //ishraq Start
  static DateTime ishraqDateTime = sunriseDateTime.add(Duration(minutes: 15));
  static String ishraqStart = formatTime(ishraqDateTime);

  //dhuhr Start
  static String get dhuhrStartTime {
    if (prayerTimes != null) {
      return prayerTimes!.dhuhrStartTime.toString();
    } else {
      return 'Failed to get';
    }
  }

  static DateTime dhuhrStartDateTime = DateTime.parse(dhuhrStartTime);
  static String dhuhrStart = formatTime(dhuhrStartDateTime);

  //dhuhr end
  static String get dhuhrEndTime {
    if (prayerTimes != null) {
      return prayerTimes!.dhuhrEndTime.toString();
    } else {
      return 'Failed to get';
    }
  }

  static DateTime dhuhrEndDateTime = DateTime.parse(dhuhrEndTime);
  static String dhuhrEnd = formatTime(dhuhrEndDateTime);

  //Asr Start
  static String get asrStartTime {
    if (prayerTimes != null) {
      return prayerTimes!.asrStartTime.toString();
    } else {
      return 'Failed to get';
    }
  }

  static DateTime asrStartDateTime = DateTime.parse(asrStartTime);
  static String asrStart = formatTime(asrStartDateTime);

  //Asr End
  static String get asrEndTime {
    if (prayerTimes != null) {
      return prayerTimes!.asrEndTime.toString();
    } else {
      return 'Failed to get';
    }
  }

  static DateTime asrEndDateTime = DateTime.parse(asrEndTime);
  static String asrEnd = formatTime(asrEndDateTime);

  //Sunset
  static String get sunsetStartTime {
    if (prayerTimes != null) {
      return prayerTimes!.maghribStartTime.toString();
    } else {
      return 'Failed to get';
    }
  }

  static DateTime sunsetDateTime = DateTime.parse(sunsetStartTime);
  static String sunset = formatTime(sunsetDateTime);

  //Magrib & ifter
  static String get magribStartTime {
    if (prayerTimes != null) {
      return prayerTimes!.maghribStartTime.toString();
    } else {
      return 'Failed to get';
    }
  }

  static DateTime magribStartDateTime = DateTime.parse(magribStartTime);
  static String magribStart = formatTime(magribStartDateTime);

  //Magrib End
  static String get magribEndTime {
    if (prayerTimes != null) {
      return prayerTimes!.maghribEndTime.toString();
    } else {
      return 'Failed to get';
    }
  }

  static DateTime magribEndDateTime = DateTime.parse(magribEndTime);
  static String magribEnd = formatTime(magribEndDateTime);

  //Isha Start
  static String get ishaStartTime {
    if (prayerTimes != null) {
      return prayerTimes!.ishaStartTime.toString();
    } else {
      return 'Failed to get';
    }
  }

  static DateTime ishaStartDateTime = DateTime.parse(ishaStartTime);
  static String ishaStart = formatTime(ishaStartDateTime);

  //Isha End
  static String get ishaEndTime {
    if (prayerTimes != null) {
      return prayerTimes!.ishaEndTime.toString();
    } else {
      return 'Failed to get';
    }
  }

  static DateTime ishaEndDateTime = DateTime.parse(ishaEndTime);
  static String ishaEnd = formatTime(ishaEndDateTime);

  //set a variable on 12:00 AM
  // static String midNight = '${DateTime.now().copyWith(hour: 0, minute: 0)} AM';
  static String midNight = '12:00 AM';


  //current Prayer
  static String currentPrayerName=prayerTimes!.currentPrayer();
  static DateTime current = prayerTimes!.timeForPrayer(currentPrayerName) ??(currentPrayerName=='ishabefore'?PrayerTime.ishaStartDateTime:DateTime.now() );
  static String currentPrayerStart = formatTime(current);
  static String currentEnd=currentEndTime(currentPrayerName);


  // static String next = prayerTimes!.nextPrayer();
  // static DateTime? currentDateTime = prayerTimes!.timeForPrayer(current);
  // static DateTime? nextDateTime = prayerTimes!.timeForPrayer(next);
  // static String currentStart = formatTimeNoLocal(currentDateTime!);
  // static String currentEnd = formatTimeNoLocal(nextDateTime!);
}

String formatTime(DateTime dateTime) {
  return DateFormat('hh:mm a').format(dateTime.toLocal());
}

String formatTimeNoLocal(DateTime dateTime) {
  return DateFormat('hh:mm a').format(dateTime);
}


String currentEndTime(String prayerName) {
  if(prayerName=='fajr'){
    return PrayerTime.fajrEnd;
  }else if(prayerName=='dhuhr'){
    return PrayerTime.dhuhrEnd;
  }else if(prayerName=='asr'){
    return PrayerTime.asrEnd;
  }else if(prayerName=='maghrib'){
    return PrayerTime.magribEnd;
  }else if(prayerName=='isha'){
    return PrayerTime.ishaEnd;
  }else if(prayerName=='ishabefore'){
    return PrayerTime.ishaEnd;
  }
  return 'Failed';
}



