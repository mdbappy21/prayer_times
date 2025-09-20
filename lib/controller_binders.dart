import 'package:get/get.dart';
import 'package:prayer_time/state_holders/date_controller.dart';
import 'package:prayer_time/state_holders/prayer_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>PrayerController(),fenix: true);
    Get.lazyPut(()=>DateController(),fenix: true);
  }

}