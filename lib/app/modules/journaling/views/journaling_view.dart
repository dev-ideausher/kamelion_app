import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kamelion/app/components/activities/journal_app_bar.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:table_calendar/table_calendar.dart';

import '../controllers/journaling_controller.dart';

class JournalingView extends GetView<JournalingController> {
  const JournalingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.CREATE_TIME_LINE);
        },
        backgroundColor: context.brandColor1,
        shape: const CircleBorder(),
        child: Icon(Icons.add, size: 20.ksp, color: context.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              JournalAppBar(tabController: controller.calanderTabController),

              Container(
                height: context.height,
                child: ListView.builder(
                  itemCount: controller.entries.length,
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  itemBuilder: (context, index) {
                    final entry = controller.entries[index];
                    final isLast = index == controller.entries.length - 1;

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Timeline line and time
                        Column(
                          children: [
                            Text(
                              entry.time,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                            Container(
                              width: 2,
                              height: isLast ? 40 : 80,
                              color: Colors.green,
                            ),
                          ],
                        ),
                        SizedBox(width: 12),

                        // Card
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 20),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Image
                                //
                                CommonImageView(
                                  svgPath: ImageConstant.happyMood,
                                ),
                                SizedBox(width: 10),
                                // Text content
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              entry.title,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: getMoodColor(entry.mood),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              entry.mood,
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        entry.description,
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Color getMoodColor(String mood) {
  switch (mood) {
    case 'Happy':
      return Colors.green;
    case 'Good':
      return Colors.orange;
    case 'Sad':
      return Colors.red;
    default:
      return Colors.grey;
  }
}

Widget _buildJournalSection() {
  return Container(
    color: const Color(0xFF147B5A), // Green background
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'My Journals',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        // Simulated Calendar (placeholder)
        CustomCalendarSection(),
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(child: Text('Calendar Placeholder')),
        ),
        const SizedBox(height: 16),
        _buildJournalTile(
          time: '10:00',
          emoji: '😊',
          mood: 'Happy',
          description:
              'Feeling Positive Today 😊\nI’m grateful for the supportive phone call I had with my best friend.',
        ),
        _buildJournalTile(
          time: '14:00',
          emoji: '🎁',
          mood: 'Good',
          description:
              'Got a gift from my BF, OMG!\nI experienced pure joy while playing with my dog in the park.',
        ),
      ],
    ),
  );
}

Widget _buildJournalTile({
  required String time,
  required String emoji,
  required String mood,
  required String description,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Row(
      children: [
        Column(
          children: [
            Text(time, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Container(width: 4, height: 40, color: Colors.green),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$emoji  $mood',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(description),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildActivitiesSection() {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        _buildActivityTile(
          icon: Icons.mood,
          title: 'Mood Tracker',
          subtitle: 'Track your mood',
          color: Colors.green.shade50,
          badgeCount: 6,
        ),
        _buildActivityTile(
          icon: Icons.local_fire_department,
          title: 'Challenges',
          subtitle: 'Exciting challenges',
          color: Colors.red.shade50,
          badgeCount: 6,
        ),
        _buildActivityTile(
          icon: Icons.menu_book,
          title: 'Journaling',
          subtitle: 'Note down every detail',
          color: Colors.orange.shade50,
          badgeCount: 6,
        ),
        _buildActivityTile(
          icon: Icons.psychology,
          title: 'Personality Test',
          subtitle: 'Check your personality',
          color: Colors.pink.shade50,
          badgeCount: 6,
        ),
      ],
    ),
  );
}

Widget _buildActivityTile({
  required IconData icon,
  required String title,
  required String subtitle,
  required Color color,
  required int badgeCount,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Row(
      children: [
        Icon(icon, size: 36, color: Colors.black54),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
        ),
        CircleAvatar(
          radius: 14,
          backgroundColor: Colors.white,
          child: Text(
            '$badgeCount',
            style: const TextStyle(fontSize: 12, color: Colors.black),
          ),
        ),
      ],
    ),
  );
}

class CustomCalendarSection extends StatefulWidget {
  const CustomCalendarSection({super.key});

  @override
  State<CustomCalendarSection> createState() => _CustomCalendarSectionState();
}

class _CustomCalendarSectionState extends State<CustomCalendarSection> {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Horizontal Dates List (top part like in POIV)
        _buildWeekDateRow(),

        const SizedBox(height: 16),

        // Full Calendar View
        TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: focusedDay,
          selectedDayPredicate: (day) => isSameDay(selectedDay, day),
          onDaySelected: (selected, focused) {
            setState(() {
              selectedDay = selected;
              focusedDay = focused;
            });
          },
          calendarStyle: const CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
          ),
          headerVisible: false,
          daysOfWeekVisible: false,
        ),
      ],
    );
  }

  Widget _buildWeekDateRow() {
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
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.green : Colors.white,
                    borderRadius: BorderRadius.circular(16),
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
                    ],
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
