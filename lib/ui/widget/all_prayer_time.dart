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
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text("Sahri End",
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(prayerController.ishaEnd,
                            style: Theme.of(context).textTheme.titleMedium)),
                    Expanded(flex: 1, child: Icon(Icons.alarm))
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text("Fajr Start",
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(prayerController.fajrStart,
                            style: Theme.of(context).textTheme.titleMedium)),
                    Expanded(flex: 1, child: Icon(Icons.alarm))
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text("Fajr End",
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(prayerController.fajrEnd,
                            style: Theme.of(context).textTheme.titleMedium)),
                    Expanded(flex: 1, child: Icon(Icons.alarm))
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text("Sunrise Start",
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(prayerController.sunrise,
                            style: Theme.of(context).textTheme.titleMedium)),
                    Expanded(flex: 1, child: Icon(Icons.alarm))
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text("Ishraq Start",
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(prayerController.ishraq,
                            style: Theme.of(context).textTheme.titleMedium)),
                    Expanded(flex: 1, child: Icon(Icons.alarm))
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text("Dhuhr Start",
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(prayerController.dhuhrStart,
                            style: Theme.of(context).textTheme.titleMedium)),
                    Expanded(flex: 1, child: Icon(Icons.alarm))
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text("Dhuhr End",
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(prayerController.dhuhrEnd,
                            style: Theme.of(context).textTheme.titleMedium)),
                    Expanded(flex: 1, child: Icon(Icons.alarm))
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text("Asr Start",
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(prayerController.asrStart,
                            style: Theme.of(context).textTheme.titleMedium)),
                    Expanded(flex: 1, child: Icon(Icons.alarm))
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text("Asr End",
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(prayerController.asrEnd,
                            style: Theme.of(context).textTheme.titleMedium)),
                    Expanded(flex: 1, child: Icon(Icons.alarm))
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text("Sunset",
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(prayerController.sunset,
                            style: Theme.of(context).textTheme.titleMedium)),
                    Expanded(flex: 1, child: Icon(Icons.alarm))
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text("Magrib / Ifter",
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(prayerController.maghribStart,
                            style: Theme.of(context).textTheme.titleMedium)),
                    Expanded(flex: 1, child: Icon(Icons.alarm))
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text("Magrib End",
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(prayerController.maghribEnd,
                            style: Theme.of(context).textTheme.titleMedium)),
                    Expanded(flex: 1, child: Icon(Icons.alarm))
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text("Isha Start",
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(prayerController.ishaStart,
                            style: Theme.of(context).textTheme.titleMedium)),
                    Expanded(flex: 1, child: Icon(Icons.alarm))
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text("Isha End",
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(prayerController.ishaEnd,
                            style: Theme.of(context).textTheme.titleMedium)),
                    Expanded(flex: 1, child: Icon(Icons.alarm))
                  ],
                ),
                SizedBox(height: 8),
              ],
            );
          }
        ),
      ),
    );
  }
}
