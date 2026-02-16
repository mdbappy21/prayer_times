import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    // -----------------------
    // English
    // -----------------------
    'en_US': {
      // App / General
      'app_name': 'Prayer App',
      'prayer_time': 'Prayer Time',
      'current_prayer': 'Current Prayer',
      'next_prayer': 'Next Prayer',
      'settings': 'Settings',
      'select_city': 'Select City',
      'choose_division': 'Choose Division',
      'choose_city': 'Choose City',
      'save': 'Save',
      'cancel': 'Cancel',
      'loading': 'Loading',
      'unknown': 'Unknown',
      'hijri': 'Hijri',
      'gregorian': 'Gregorian',

      // AM / PM
      'am': 'AM',
      'pm': 'PM',
      'am_full': 'Ante Meridiem',
      'pm_full': 'Post Meridiem',

      // Weekdays
      'weekday_sunday': 'Sunday',
      'weekday_monday': 'Monday',
      'weekday_tuesday': 'Tuesday',
      'weekday_wednesday': 'Wednesday',
      'weekday_thursday': 'Thursday',
      'weekday_friday': 'Friday',
      'weekday_saturday': 'Saturday',

      // Gregorian months
      'month_january': 'January',
      'month_february': 'February',
      'month_march': 'March',
      'month_april': 'April',
      'month_may': 'May',
      'month_june': 'June',
      'month_july': 'July',
      'month_august': 'August',
      'month_september': 'September',
      'month_october': 'October',
      'month_november': 'November',
      'month_december': 'December',

      // Hijri months (English names you provided)
      'hijri_month_1': "Muharram",
      'hijri_month_2': "Safar",
      'hijri_month_3': "Rabi' Al-Awwal",
      'hijri_month_4': "Rabi' Al-Thani",
      'hijri_month_5': "Jumada Al-Awwal",
      'hijri_month_6': "Jumada Al-Thani",
      'hijri_month_7': "Rajab",
      'hijri_month_8': "Sha'aban",
      'hijri_month_9': "Ramadan",
      'hijri_month_10': "Shawwal",
      'hijri_month_11': "Dhu Al-Qi'dah",
      'hijri_month_12': "Dhu Al-Hijjah",

      // Prayer names & variants (from PrayerType)
      'fajr': 'Fajr',
      'sunrise': 'Sunrise',
      'dhuhr': 'Dhuhr',
      'asr': 'Asr',
      'maghrib': 'Maghrib',
      'isha': 'Isha',
      'ishabefore': 'Isha (before midnight)',
      'fajrafter': 'Fajr (after midnight)',
      'none': 'None',
      'sehri': 'Sehri',

      // Extra prayer-related labels
      'sahri_end': 'Sahri End',
      'fajr_start': 'Fajr Start',
      'sunrise_time': 'Sunrise Time',
      'isha_end': 'Isha End',

      // Cities (division / city list)
      // Dhaka Division
      'city_dhaka': 'Dhaka',
      'city_faridpur': 'Faridpur',
      'city_gazipur': 'Gazipur',
      'city_gopalganj': 'Gopalganj',
      'city_kishoreganj': 'Kishoreganj',
      'city_madaripur': 'Madaripur',
      'city_manikganj': 'Manikganj',
      'city_munshiganj': 'Munshiganj',
      'city_narayanganj': 'Narayanganj',
      'city_narsingdi': 'Narsingdi',
      'city_rajbari': 'Rajbari',
      'city_shariatpur': 'Shariatpur',
      'city_tangail': 'Tangail',

      // Rajshahi Division
      'city_rajshahi': 'Rajshahi',
      'city_bogura': 'Bogura',
      'city_chapainawabganj': 'Chapainawabganj',
      'city_joypurhat': 'Joypurhat',
      'city_naogaon': 'Naogaon',
      'city_natore': 'Natore',
      'city_pabna': 'Pabna',
      'city_sirajganj': 'Sirajganj',

      // Rangpur Division
      'city_rangpur': 'Rangpur',
      'city_dinajpur': 'Dinajpur',
      'city_gaibandha': 'Gaibandha',
      'city_kurigram': 'Kurigram',
      'city_lalmonirhat': 'Lalmonirhat',
      'city_nilphamari': 'Nilphamari',
      'city_panchagarh': 'Panchagarh',
      'city_thakurgaon': 'Thakurgaon',

      // Sylhet Division
      'city_sylhet': 'Sylhet',
      'city_habiganj': 'Habiganj',
      'city_moulvibazar': 'Moulvibazar',
      'city_sunamganj': 'Sunamganj',

      // Barishal Division
      'city_barishal': 'Barishal',
      'city_barguna': 'Barguna',
      'city_bhola': 'Bhola',
      'city_jhalokati': 'Jhalokati',
      'city_patuakhali': 'Patuakhali',
      'city_pirojpur': 'Pirojpur',

      // Khulna Division
      'city_khulna': 'Khulna',
      'city_bagerhat': 'Bagerhat',
      'city_chuadanga': 'Chuadanga',
      'city_jashore': 'Jashore',
      'city_jhenaidah': 'Jhenaidah',
      'city_kushtia': 'Kushtia',
      'city_magura': 'Magura',
      'city_meherpur': 'Meherpur',
      'city_narail': 'Narail',
      'city_satkhira': 'Satkhira',

      // Chittagong Division
      'city_chattogram': 'Chattogram',
      'city_bandarban': 'Bandarban',
      'city_brahmanbaria': 'Brahmanbaria',
      'city_chandpur': 'Chandpur',
      'city_comilla': 'Comilla',
      'city_coxs_bazar': 'CoxsBazar',
      'city_feni': 'Feni',
      'city_khagrachhari': 'Khagrachhari',
      'city_lakshmipur': 'Lakshmipur',
      'city_noakhali': 'Noakhali',
      'city_rangamati': 'Rangamati',

      // Mymensingh Division
      'city_mymensingh': 'Mymensingh',
      'city_jamalpur': 'Jamalpur',
      'city_netrokona': 'Netrokona',
      'city_sherpur': 'Sherpur',
    },

    // -----------------------
    // Bangla
    // -----------------------
    'bn_BD': {
      // App / General
      'app_name': 'নামাজ অ্যাপ',
      'prayer_time': 'নামাজের সময়',
      'current_prayer': 'বর্তমান নামাজ',
      'next_prayer': 'পরবর্তী নামাজ',
      'settings': 'সেটিংস',
      'select_city': 'শহর নির্বাচন করুন',
      'choose_division': 'বিভাগ নির্বাচন করুন',
      'choose_city': 'শহর নির্বাচন করুন',
      'save': 'সংরক্ষণ',
      'cancel': 'বাতিল',
      'loading': 'লোড হচ্ছে',
      'unknown': 'অজানা',
      'hijri': 'হিজরি',
      'gregorian': 'গ্রেগরিয়ান',

      // AM / PM
      'am': 'AM',
      'pm': 'PM',
      'am_full': 'পূর্বাহ্ন',
      'pm_full': 'অপরাহ্ন',

      // Weekdays
      'weekday_sunday': 'রবিবার',
      'weekday_monday': 'সোমবার',
      'weekday_tuesday': 'মঙ্গলবার',
      'weekday_wednesday': 'বুধবার',
      'weekday_thursday': 'বৃহস্পতিবার',
      'weekday_friday': 'শুক্রবার',
      'weekday_saturday': 'শনিবার',

      // Gregorian months (Bangla)
      'month_january': 'জানুয়ারি',
      'month_february': 'ফেব্রুয়ারি',
      'month_march': 'মার্চ',
      'month_april': 'এপ্রিল',
      'month_may': 'মে',
      'month_june': 'জুন',
      'month_july': 'জুলাই',
      'month_august': 'আগস্ট',
      'month_september': 'সেপ্টেম্বর',
      'month_october': 'অক্টোবর',
      'month_november': 'নভেম্বর',
      'month_december': 'ডিসেম্বর',

      // Hijri months (Bangla transliteration / common names)
      'hijri_month_1': 'মুহররম',
      'hijri_month_2': 'সফর',
      'hijri_month_3': "রবিউল আউয়াল",
      'hijri_month_4': "রবিউস সানি",
      'hijri_month_5': "জমাদিউল আউয়াল",
      'hijri_month_6': "জমাদিউস সানি",
      'hijri_month_7': "রজব",
      'hijri_month_8': "শাবান",
      'hijri_month_9': "রমজান",
      'hijri_month_10': "শাওয়াল",
      'hijri_month_11': "জিলক্বদ",
      'hijri_month_12': "জিলহজ",

      // Prayer names & variants (from PrayerType) - Bangla
      'fajr': 'ফজর',
      'sunrise': 'সূর্যোদয়',
      'dhuhr': 'যোহর',
      'asr': 'আসর',
      'maghrib': 'মাগরিব',
      'isha': 'ইশা',
      'ishabefore': 'ইশা (মধ্যরাত পূর্বে)',
      'fajrafter': 'ফজর (মধ্যরাত পরে)',
      'none': 'কোনোটি নয়',
      'sehri': 'সেহরি',

      // Extra prayer-related labels
      'sahri_end': 'সাহরি শেষ',
      'fajr_start': 'ফজর শুরু',
      'sunrise_time': 'সূর্যোদয়',
      'isha_end': 'ইশা শেষ',

      // Cities (Bangla names)
      // Dhaka Division
      'city_dhaka': 'ঢাকা',
      'city_faridpur': 'ফরিদপুর',
      'city_gazipur': 'গাজীপুর',
      'city_gopalganj': 'গোপালগঞ্জ',
      'city_kishoreganj': 'কিশোরগঞ্জ',
      'city_madaripur': 'মাদারীপুর',
      'city_manikganj': 'মানিকগঞ্জ',
      'city_munshiganj': 'মুন্সিগঞ্জ',
      'city_narayanganj': 'নারায়ণগঞ্জ',
      'city_narsingdi': 'নরসিংদী',
      'city_rajbari': 'রাজবাড়ী',
      'city_shariatpur': 'শরীয়তপুর',
      'city_tangail': 'টাঙ্গাইল',

      // Rajshahi Division
      'city_rajshahi': 'রাজশাহী',
      'city_bogura': 'বগুড়া',
      'city_chapainawabganj': 'চাঁপাইনবাবগঞ্জ',
      'city_joypurhat': 'জয়পুরহাট',
      'city_naogaon': 'নওগাঁ',
      'city_natore': 'নাটোর',
      'city_pabna': 'পাবনা',
      'city_sirajganj': 'সিরাজগঞ্জ',

      // Rangpur Division
      'city_rangpur': 'রংপুর',
      'city_dinajpur': 'দিনাজপুর',
      'city_gaibandha': 'গাইবান্ধা',
      'city_kurigram': 'কুড়িগ্রাম',
      'city_lalmonirhat': 'লালমনিরহাট',
      'city_nilphamari': 'নীলফামারী',
      'city_panchagarh': 'পঞ্চগড়',
      'city_thakurgaon': 'ঠাকুরগাঁও',

      // Sylhet Division
      'city_sylhet': 'সিলেট',
      'city_habiganj': 'হবিগঞ্জ',
      'city_moulvibazar': 'মৌলভীবাজার',
      'city_sunamganj': 'সুনামগঞ্জ',

      // Barishal Division
      'city_barishal': 'বরিশাল',
      'city_barguna': 'বরগুনা',
      'city_bhola': 'ভোলা',
      'city_jhalokati': 'ঝালকাঠি',
      'city_patuakhali': 'পটুয়াখালী',
      'city_pirojpur': 'পিরোজপুর',

      // Khulna Division
      'city_khulna': 'খুলনা',
      'city_bagerhat': 'বাগেরহাট',
      'city_chuadanga': 'চুয়াডাঙ্গা',
      'city_jashore': 'যশোর',
      'city_jhenaidah': 'ঝিনাইদাহ',
      'city_kushtia': 'কুষ্টিয়া',
      'city_magura': 'মাগুরা',
      'city_meherpur': 'মেহেরপুর',
      'city_narail': 'নড়াইল',
      'city_satkhira': 'সাতক্ষীরা',

      // Chittagong Division
      'city_chattogram': 'চট্টগ্রাম',
      'city_bandarban': 'বান্দরবান',
      'city_brahmanbaria': 'ব্রাহ্মণবাড়িয়া',
      'city_chandpur': 'চাঁদপুর',
      'city_comilla': 'কুমিল্লা',
      'city_coxs_bazar': 'কক্সবাজার',
      'city_feni': 'ফেনী',
      'city_khagrachhari': 'খাগড়াছড়ি',
      'city_lakshmipur': 'লক্ষ্মীপুর',
      'city_noakhali': 'নোয়াখালী',
      'city_rangamati': 'রাঙামাটি',

      // Mymensingh Division
      'city_mymensingh': 'ময়মনসিংহ',
      'city_jamalpur': 'জামালপুর',
      'city_netrokona': 'নেত্রকোনা',
      'city_sherpur': 'শেরপুর',
    },
  };
}
