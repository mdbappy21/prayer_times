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
  static String fajrStart = formatTime(fajrStartDateTime.add(Duration(minutes: 1)));

  //Fajr End Time
  static String get fajrEndTime {
    if (prayerTimes != null) {
      return prayerTimes!.fajrEndTime.toString();
    } else {
      return 'Failed to get';
    }
  }
  static DateTime fajrEndDateTime = DateTime.parse(fajrEndTime);
  static String fajrEnd = formatTime(fajrEndDateTime.subtract(Duration(minutes: 1)));

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

  //ishraq End
  static DateTime ishraqEndDateTime= dhuhrStartDateTime.subtract(Duration(minutes: 15));
  static String ishraqEnd=formatTime(ishraqEndDateTime);

  //dhuhr Start
  static String get dhuhrStartTime {
    if (prayerTimes != null) {
      return prayerTimes!.dhuhrStartTime.toString();
    } else {
      return 'Failed to get';
    }
  }
  static DateTime dhuhrStartDateTime = DateTime.parse(dhuhrStartTime);
  static String dhuhrStart = formatTime(dhuhrStartDateTime.add(Duration(minutes: 1)));

  //dhuhr end
  static String get dhuhrEndTime {
    if (prayerTimes != null) {
      return prayerTimes!.dhuhrEndTime.toString();
    } else {
      return 'Failed to get';
    }
  }
  static DateTime dhuhrEndDateTime = DateTime.parse(dhuhrEndTime);
  static String dhuhrEnd = formatTime(dhuhrEndDateTime.subtract(Duration(minutes: 1)));

  //Asr Start
  static String get asrStartTime {
    if (prayerTimes != null) {
      return prayerTimes!.asrStartTime.toString();
    } else {
      return 'Failed to get';
    }
  }
  static DateTime asrStartDateTime = DateTime.parse(asrStartTime);
  static String asrStart = formatTime(asrStartDateTime.add(Duration(minutes: 1)));

  //Asr End
  static String get asrEndTime {
    if (prayerTimes != null) {
      return prayerTimes!.asrEndTime.toString();
    } else {
      return 'Failed to get';
    }
  }
  static DateTime asrEndDateTime = DateTime.parse(asrEndTime);
  static String asrEnd = formatTime(asrEndDateTime.subtract(Duration(minutes: 1)));

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
  static String magribStart = formatTime(magribStartDateTime.add(Duration(minutes: 1)));

  //Magrib End
  static String get magribEndTime {
    if (prayerTimes != null) {
      return prayerTimes!.maghribEndTime.toString();
    } else {
      return 'Failed to get';
    }
  }
  static DateTime magribEndDateTime = DateTime.parse(magribEndTime);
  static String magribEnd = formatTime(magribEndDateTime.subtract(Duration(minutes: 1)));

  //Isha Start
  static String get ishaStartTime {
    if (prayerTimes != null) {
      return prayerTimes!.ishaStartTime.toString();
    } else {
      return 'Failed to get';
    }
  }
  static DateTime ishaStartDateTime = DateTime.parse(ishaStartTime);
  static String ishaStart = formatTime(ishaStartDateTime.add(Duration(minutes: 1)));

  //Isha End
  static String get ishaEndTime {
    if (prayerTimes != null) {
      return prayerTimes!.ishaEndTime.toString();
    } else {
      return 'Failed to get';
    }
  }
  static DateTime ishaEndDateTime = DateTime.parse(ishaEndTime);
  static String ishaEnd = formatTime(ishaEndDateTime.subtract(Duration(minutes: 1)));

  //Sehri End
  static String sehriEnd=formatTime(ishaEndDateTime);

  //Mid Night to correct Hijri Date.
  static String midNight = '12:00 AM';

  //current Prayer
  static String currentPrayerName=prayerNameCorrection(prayerTimes!.currentPrayer()) ;
  static DateTime current = getCurrentPrayerStartTime(currentPrayerName);
  static String currentPrayerStart = formatTime(current);
  static String currentEnd=getCurrentPrayerEndTime(currentPrayerName);

}

String prayerNameCorrection(String correctName){
  DateTime currentTime=DateTime.now();
  DateTime sunsetForbidden=PrayerTime.magribStartDateTime.subtract(Duration(minutes: 5));
  if(currentTime.isAfter(PrayerTime.ishraqDateTime) && currentTime.isBefore(PrayerTime.dhuhrStartDateTime.subtract(Duration(minutes: 16)))){
   return correctName="Ishraq/Chast";
  }else if(currentTime.isAfter(PrayerTime.fajrEndDateTime) && currentTime.isBefore(PrayerTime.ishraqDateTime)){
    return 'Forbidden Sunrise';
  }else if(currentTime.isAfter(PrayerTime.ishraqEndDateTime) && currentTime.isBefore(PrayerTime.dhuhrStartDateTime)){
    return 'Forbidden Mid Noon';
  }else if(currentTime.isAfter(sunsetForbidden) && currentTime.isBefore(PrayerTime.magribStartDateTime)){
    return 'Forbidden Sunset';
  }
  else{
    return correctName;
  }
}

String formatTime(DateTime dateTime) {
  return DateFormat('hh:mm a').format(dateTime.toLocal());
}

String getCurrentPrayerEndTime(String prayerName) {
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
  } else if(prayerName=='Ishraq/Chast'){
    return PrayerTime.ishraqEnd;
  } else if(prayerName=='Forbidden Mid Noon'){
    return PrayerTime.dhuhrStart;
  }else if(prayerName=='Forbidden Sunset'){
    return PrayerTime.sunset;
  }else if(prayerName=='Forbidden Sunrise'){
    return PrayerTime.ishraqStart;
  }
  return 'Failed';
}

DateTime getCurrentPrayerStartTime(String prayerName) {
  if(prayerName=='fajr'){
    return PrayerTime.fajrStartDateTime;
  }else if(prayerName=='dhuhr'){
    return PrayerTime.dhuhrStartDateTime;
  }else if(prayerName=='asr'){
    return PrayerTime.asrStartDateTime;
  }else if(prayerName=='maghrib'){
    return PrayerTime.magribStartDateTime;
  }else if(prayerName=='isha'){
    return PrayerTime.ishaStartDateTime;
  } else if(prayerName=='ishabefore'){
    return DateTime.now();
  }else if(prayerName=='Ishraq/Chast'){
    return PrayerTime.ishraqDateTime;
  }else if(prayerName=='Forbidden Mid Noon'){
    return PrayerTime.ishraqEndDateTime.add(Duration(minutes: 1));
  }else if(prayerName=='Forbidden Sunset'){
    return PrayerTime.sunsetDateTime.subtract(Duration(minutes: 5));
  }else if(prayerName=='Forbidden Sunrise'){
    return PrayerTime.sunriseDateTime;
  }
  return DateTime.now();
}