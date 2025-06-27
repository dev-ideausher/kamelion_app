import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kamelion/app/modules/mood_tracker/controllers/mood_tracker_controller.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:table_calendar/table_calendar.dart';



class MoodTrackerCalendarSection extends StatefulWidget {
  const MoodTrackerCalendarSection({super.key});

  @override
  State<MoodTrackerCalendarSection> createState() => _MoodTrackerCalendarSectionState();
}

class _MoodTrackerCalendarSectionState extends State<MoodTrackerCalendarSection> {
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay= DateTime.now();
  String selectedMonth = "January";
  final MoodTrackerController ctrl = Get.find();
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
    return Column(
      children: [
        // Full Calendar View
        // Row(
        //   children: [
        //     Spacer(),
        //     Icon(Icons.calendar_today, color: context.white),
        //     10.kwidthBox,
        //     DropdownButtonHideUnderline(
        //       child: DropdownButton<String>(
        //         value: selectedMonth,
        //         icon: Icon(Icons.arrow_drop_down, color: context.white),
        //         dropdownColor: Colors.white,
        //         style: TextStyle(fontSize: 16, color: context.white),
        //         onChanged: (String? newValue) {
        //           if (newValue != null) {
        //             setState(() {
        //               selectedMonth = newValue;
        //             });
        //           }
        //         },
        //         items:
        //             [
        //               'January',
        //               'February',
        //               'March',
        //               'April',
        //               'May',
        //               'June',
        //               'July',
        //               'August',
        //               'September',
        //               'October',
        //               'November',
        //               'December',
        //             ].map<DropdownMenuItem<String>>((String value) {
        //               return DropdownMenuItem<String>(
        //                 value: value,
        //                 child: Text(value),
        //               );
        //             }).toList(),
        //       ),
        //     ),
        //   ],
        // ),
        TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: focusedDay,
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyleUtil.genSans400(fontSize: 11.ksp),
            weekendStyle: TextStyleUtil.genSans400(fontSize: 11.ksp),
            decoration: BoxDecoration(),
          ),
          selectedDayPredicate: (day) => isSameDay(selectedDay, day),
          onDaySelected: (selected, focused) {
            setState(() {
              selectedDay = selected;
              focusedDay = focused;
            });
            ctrl.onDateSelected(selected);
          },
          headerStyle: HeaderStyle(
            titleTextStyle: TextStyleUtil.genSans400(fontSize: 12.ksp),
            formatButtonVisible: false,
            leftChevronIcon: Icon(
              Icons.arrow_back_ios,
              color: context.white,
              size: 12.ksp,
            ),
            rightChevronIcon: Icon(
              Icons.arrow_forward_ios,
              color: context.white,
              size: 12.ksp,
            ),
          ),
          calendarStyle: CalendarStyle(
            weekendTextStyle: TextStyleUtil.genSans400(fontSize: 12.ksp),
            todayDecoration: BoxDecoration(
              color: context.brandColor1,
              shape: BoxShape.circle,
            ),
            selectedTextStyle: TextStyleUtil.genSans400(
              fontSize: 12.ksp,
              color: context.brandColor1,
            ),
            disabledTextStyle: TextStyleUtil.genSans400(fontSize: 12.ksp),
            defaultTextStyle: TextStyleUtil.genSans400(fontSize: 12.ksp),
            todayTextStyle: TextStyleUtil.genSans400(fontSize: 12.ksp),
            selectedDecoration: BoxDecoration(
              color: context.white,
              shape: BoxShape.circle,
            ),
          ),
          headerVisible: true,
          daysOfWeekVisible: true,
        ),
      ],
    );
  }

}
