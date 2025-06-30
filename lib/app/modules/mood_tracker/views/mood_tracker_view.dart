import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';


import 'package:intl/intl.dart';
import 'package:kamelion/app/components/activities/mood_track_week_calender.dart';

import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../components/activities/mood_tracker_app_bar.dart';
import '../../../components/activities/mood_tracker_calender.dart';

import '../../../models/journal_list_item.dart';
import '../../../services/custom_textfield.dart';
import '../../../services/text_style_util.dart';


import '../../home/controllers/home_controller.dart';
import '../controllers/mood_tracker_controller.dart';

class MoodTrackerView extends GetView<MoodTrackerController> {
  const MoodTrackerView({super.key});
  @override
  Widget build(BuildContext context) {
    final todayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());

    return Scaffold(
      floatingActionButton: Obx(() {
        return controller.selectedDate.value == todayStr
            ? FloatingActionButton(
          onPressed: () =>Get.find<HomeController>().showMoodPopup(context),
          backgroundColor: context.brandColor1,
          shape: const CircleBorder(),
          child: Icon(Icons.add, size: 20.ksp, color: context.white),
        )
            : SizedBox.shrink();
      }),
      body: SafeArea(
        child:
        DefaultTabController(
          length: 2,
          child: NestedScrollView(
            // ── 1) BUILD THE COLLAPSIBLE HEADER ──
            headerSliverBuilder: (_, __) => [
              Obx(()=>  SliverAppBar(automaticallyImplyLeading: false,
                pinned: true,
                stretch: true,
                elevation: 0,
                backgroundColor: context.brandColor1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24),bottomRight: Radius.circular(24))),
                expandedHeight:  controller.currentCatenderIndex.value == 1
                    ? 460.ksp
                    : 270.ksp,    // same as your “calendar” height
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Column(
                    children: [
                      // — your back button + search + title + total journals —
                      Padding(
                        padding: EdgeInsets.all(16.ksp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                height: 25.ksp,
                                width: 25.ksp,
                                decoration: BoxDecoration(
                                  color: context.lightBrandColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 4.0.ksp),
                                  child: Center(
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      size: 11.ksp,
                                      color: context.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            24.kheightBox,
                            Row(
                              children: [
                                Text(
                                  'My Mood',
                                  style: TextStyleUtil.genSans500(fontSize: 21.ksp),
                                ),
                                Spacer(),
                                CalenderTabBar(
                                  backgroundColor: context.lightBrand3Color,
                                  selectedTabColor: context.lightBrand2Color,
                                  tabController:controller.tabController,
                                  title1: "",
                                  title2: "",
                                  labelColor: ColorUtil(context).lightBrand3Color,
                                  unselectedLabelColor: ColorUtil(context).white,
                                  height: MediaQuery.of(context).size.height * 0.043,
                                  width: MediaQuery.of(context).size.width * 0.2,
                                ),
                              ],
                            ),
                            6.kheightBox,
                            Obx(()=>   Text(
                              'Total moods this year - ${controller.totalJournal.value}',
                              style: TextStyleUtil.genSans400(fontSize: 10.5.ksp),
                            )),

                            10.kheightBox,
                            // ── HERE is your CalendarSection ──
                            // Only shows when “Month” tab is active, but we can just leave it:
                            // if (controller.currentCatenderIndex.value == 1)
                            //   SizedBox(
                            //       height: 490.ksp,
                            //       child: CustomCalendarSection()),
                            // // If it’s “Week” you could instead show WeekCalenderRow()
                            // if (controller.currentCatenderIndex.value == 0)
                            //   SizedBox(
                            //       height:250.ksp,       child: WeekCalenderRow()),
                            if (controller.currentCatenderIndex.value == 1)
                              MoodTrackerCalendarSection(),
                            // If it’s “Week” you could instead show WeekCalenderRow()
                            if (controller.currentCatenderIndex.value == 0)
                              MoodTrackerWeekCalenderRow(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // ── 2) PIN THE TAB BAR at the bottom of the AppBar ──


              ),)
            ],

            // ── 3) THE SCROLLABLE BODY ──
            body:

               Container(
                      height: context.height,
                      child:
                      Obx(() {
                        if (controller.isLoading.value) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (controller.entries.isEmpty) {
                          return Center(child: Text('No moods logged on ${controller.selectedDate.value}'));
                        }

                        return ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                          itemCount: controller.entries.length,
                          itemBuilder: (context, index) {
                            final entry = controller.entries[index];
                            final isLast = index == controller.entries.length - 1;
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // ══ time + line ══
                                Column(
                                  children: [
                                    Text(entry.formattedTime,
                                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700])),
                                    Container(
                                      width: 2,
                                      height: isLast ? 40 : 80,
                                      color: context.brandColor1,
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 12),


                                        Expanded(
                                          child: Container(
                                            margin: const EdgeInsets.only(bottom: 20),
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              color: Colors.white,

                                              borderRadius: BorderRadius.circular(32),

                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.shade300,
                                                  blurRadius: 6,
                                                  offset: const Offset(0, 3),
                                                ),
                                              ],
                                            ),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                               CommonImageView(svgPath: controller.getMoodImagePath(entry.mood), width: 40, height: 40),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        entry.mood,
                                                        style: const TextStyle(
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Text(
                                                        entry.note??'',
                                                        style: const TextStyle(
                                                          color: Colors.grey,
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
                        );
                      })


                 // ListView.builder(
                      //   padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      //   itemCount: controller.entries.length,
                      //   itemBuilder: (context, index) {
                      //     final entry = controller.entries[index];
                      //     final isLast = index == controller.entries.length - 1;
                      //     return Row(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         // Timeline time + connector
                      //         Column(
                      //           children: [
                      //             Text(
                      //               entry.time,
                      //               style: TextStyle(
                      //                 fontWeight: FontWeight.bold,
                      //                 color: Colors.grey[700],
                      //               ),
                      //             ),
                      //             Container(
                      //               width: 2,
                      //               height: isLast ? 40 : 80,
                      //               color: context.brandColor1,
                      //             ),
                      //           ],
                      //         ),
                      //         const SizedBox(width: 12),
                      //
                      //         // Mood card
                      //         Expanded(
                      //           child: Container(
                      //             margin: const EdgeInsets.only(bottom: 20),
                      //             padding: const EdgeInsets.all(12),
                      //             decoration: BoxDecoration(
                      //               color: Colors.white,
                      //               borderRadius: BorderRadius.circular(14),
                      //               boxShadow: [
                      //                 BoxShadow(
                      //                   color: Colors.grey.shade300,
                      //                   blurRadius: 6,
                      //                   offset: const Offset(0, 3),
                      //                 ),
                      //               ],
                      //             ),
                      //             child: Row(
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children: [
                      //                CommonImageView(svgPath: entry.imagePath, width: 40, height: 40),
                      //                 const SizedBox(width: 10),
                      //                 Expanded(
                      //                   child: Column(
                      //                     crossAxisAlignment: CrossAxisAlignment.start,
                      //                     children: [
                      //                       Text(
                      //                         entry.title,
                      //                         style: const TextStyle(
                      //                           fontWeight: FontWeight.w600,
                      //                         ),
                      //                       ),
                      //                       const SizedBox(height: 4),
                      //                       Text(
                      //                         entry.description,
                      //                         style: const TextStyle(
                      //                           color: Colors.grey,
                      //                           fontSize: 13,
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     );
                      //   },
                      // ),


               )

          ),
        ),

      ),
    );
  }
}





