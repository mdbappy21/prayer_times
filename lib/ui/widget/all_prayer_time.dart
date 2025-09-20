import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prayer_time/state_holders/prayer_controller.dart';

class AllPrayerTime extends StatefulWidget {
  const AllPrayerTime({super.key});

  @override
  State<AllPrayerTime> createState() => _AllPrayerTimeState();
}

class _AllPrayerTimeState extends State<AllPrayerTime> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        color: Colors.transparent,
        child: GetBuilder<PrayerController>(
          builder: (prayerController) {
            return Column(
              children: [
                const SizedBox(height: 8),
                _buildPrayerInfo(prayerController,'Sahri End',prayerController.ishaEnd,Colors.tealAccent),
                const SizedBox(height: 8),
                _buildPrayerInfo(prayerController,"Fajr Start",prayerController.fajrStart,Colors.white),
                const SizedBox(height: 8),
                _buildPrayerInfo(prayerController,"Fajr End",prayerController.fajrEnd,Colors.tealAccent),
                const SizedBox(height: 8),
                _buildPrayerInfo(prayerController,"Sunrise Start",prayerController.sunrise,Colors.white),
                const SizedBox(height: 8),
                _buildPrayerInfo(prayerController,"Ishraq Start",prayerController.ishraqStart,Colors.white),
                const SizedBox(height: 8),
                _buildPrayerInfo(prayerController,"Ishraq End",prayerController.ishraqEnd,Colors.tealAccent),
                const SizedBox(height: 8),
                _buildPrayerInfo(prayerController,"Dhuhr Start",prayerController.dhuhrStart,Colors.white),
                const SizedBox(height: 8),
                _buildPrayerInfo(prayerController,"Dhuhr End",prayerController.dhuhrEnd,Colors.tealAccent),
                const SizedBox(height: 8),
                _buildPrayerInfo(prayerController,"Asr Start",prayerController.asrStart,Colors.white),
                const SizedBox(height: 8),
                _buildPrayerInfo(prayerController,"Asr End",prayerController.asrEnd,Colors.tealAccent),
                const SizedBox(height: 8),
                _buildPrayerInfo(prayerController,"Sunset",prayerController.sunset,Colors.white),
                const SizedBox(height: 8),
                _buildPrayerInfo(prayerController,"Magrib / Ifter",prayerController.maghribStart,Colors.white),
                const SizedBox(height: 8),
                _buildPrayerInfo(prayerController,"Magrib End",prayerController.maghribEnd,Colors.tealAccent),
                const SizedBox(height: 8),
                _buildPrayerInfo(prayerController,"Isha Start",prayerController.ishaStart,Colors.white),
                const SizedBox(height: 8),
                _buildPrayerInfo(prayerController,"Isha End",prayerController.ishaEnd,Colors.tealAccent),
                const SizedBox(height: 8),
              ],
            );
          }
        ),
      ),
    );
  }

  Widget _buildPrayerInfo(PrayerController prayerController,String prayerName,String prayerTime,Color color) {
    return Padding(
      padding: const EdgeInsets.only(left: 16,right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Expanded(
            // flex: 3,
            // child:
            Text(prayerName, style: Theme.of(context).textTheme.titleMedium!.copyWith(color:color)),
          // ),
          // Expanded(
            // flex: 1,
            // child:
            Text(prayerTime, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: color),),
          // ),
          // Expanded(flex: 1,
          //   child: Icon(Icons.alarm),
          // )
        ],
      ),
    );
  }
}
