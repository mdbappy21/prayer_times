import 'package:intl/intl.dart';

class GregorianDate{
  static DateTime currentDateTime=DateTime.now();
  static String dayName = DateFormat('EEEE').format(currentDateTime);
  static String monthName = DateFormat('MMMM').format(currentDateTime);
  static String day = DateFormat('d').format(currentDateTime);
  static String year = DateFormat('y').format(currentDateTime);
  static String formattedTime = DateFormat('hh:mm a').format(currentDateTime);
}