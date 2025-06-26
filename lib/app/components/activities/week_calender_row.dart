import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../modules/journaling/controllers/journaling_controller.dart';

class WeekCalenderRow extends StatefulWidget {
  const WeekCalenderRow({super.key});

  @override
  State<WeekCalenderRow> createState() => _WeekCalenderRowState();
}

class _WeekCalenderRowState extends State<WeekCalenderRow> {
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay= DateTime.now();
  final JournalingController ctrl = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ctrl.onDateSelected(selectedDay);
    });
  }
  @override
  Widget build(BuildContext context) {
    return buildWeekDateRow();
  }

  Widget buildWeekDateRow() {
    final startOfWeek = DateTime.now().subtract(
      Duration(days: DateTime.now().weekday - 1),
    );
    final dates = List.generate(
      7,
      (index) => startOfWeek.add(Duration(days: index)),
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children:
            dates.map((date) {
              final isSelected = isSameDay(date, selectedDay ?? DateTime.now());
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDay = date;
                    focusedDay = date;
                  });
                  ctrl.onDateSelected(date);
                },
                child: Container(
                  height: 80.ksp,
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.green : Colors.white,
                    borderRadius: BorderRadius.circular(30.ksp),
                    border: Border.all(color: Colors.green),
                  ),
                  child: Column(
                    children: [
                      Text(
                        DateFormat.E().format(date), // e.g., Mon
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        date.day.toString(), // e.g., 26
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.green,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      12.kheightBox,
                      Icon(
                        Icons.circle,
                        size: 6.ksp,
                        color: isSelected ? Colors.white : Colors.green,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
