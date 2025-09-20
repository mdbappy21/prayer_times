import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prayer_time/state_holders/prayer_controller.dart';
import 'package:prayer_time/ui/utility/coordinates_Cities.dart';

Future<void> showCityPickerDialog(BuildContext context) async {
  final PrayerController controller = Get.find<PrayerController>();
  String? selectedDivision;
  bool isDivisionSelected = false;

  await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          final title = isDivisionSelected ? selectedDivision! : "Choose Division";
          final listItems = isDivisionSelected ? CoordinatesCities.divisions[selectedDivision!]!.keys.toList() : CoordinatesCities.divisions.keys.toList();

          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green.shade400, Colors.green.shade900],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              width: MediaQuery.of(context).size.width * 0.8,
              height: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.green.shade400, Colors.green.shade900],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                    ),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      itemCount: listItems.length,
                      itemBuilder: (context, index) {
                        final item = listItems[index];
                        return ListTile(
                          title: Text(item),
                          onTap: () {
                            if (!isDivisionSelected) {
                              setState(() {
                                selectedDivision = item;
                                isDivisionSelected = true;
                              });
                            } else {
                              controller.initialize(
                                division: selectedDivision!,
                                city: item,
                              );
                              Get.back();
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
