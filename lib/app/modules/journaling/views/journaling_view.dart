import 'dart:developer';

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
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../components/activities/calender.dart';
import '../../../components/activities/week_calender_row.dart';
import '../../../models/journal_list_item.dart';
import '../../../services/custom_textfield.dart';
import '../../../services/text_style_util.dart';
import '../controllers/journaling_controller.dart';

class JournalingView extends GetView<JournalingController> {
  const JournalingView({super.key});
  @override
  Widget build(BuildContext context) {
    final todayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());

    return Scaffold(
      floatingActionButton: Obx(() {
        return controller.selectedDate.value == todayStr
            ? FloatingActionButton(
                onPressed: () => Get.toNamed(Routes.CREATE_TIME_LINE),
                backgroundColor: context.brandColor1,
                shape: const CircleBorder(),
                child: Icon(Icons.add, size: 20.ksp, color: context.white),
              )
            : SizedBox.shrink();
      }),
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            // ── 1) BUILD THE COLLAPSIBLE HEADER ──
            headerSliverBuilder: (_, __) => [
              Obx(
                () => SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  stretch: true,
                  elevation: 0,
                  backgroundColor: context.brandColor1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24))),
                  expandedHeight: controller.currentCatenderIndex.value == 1
                      ? 460.ksp
                      : 270.ksp, // same as your “calendar” height
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
                              10.kheightBox,
                              CustomTextField(
                                filled: true,
                                hintText: "Search by word",
                                controller: controller.searchController,
                                suffixIconWidget: controller
                                        .searchController.text.isEmpty
                                    ? null
                                    : IconButton(
                                        icon: Icon(Icons.clear),
                                        onPressed: () {
                                          controller.searchController.clear();
                                          controller.getSavedJournals(
                                              date: controller
                                                  .selectedDate.value);
                                        },
                                      ),
                                onFieldSubmitted: (value) {
                                  // When the user taps “Search” on keyboard
                                  controller.getSavedJournals(
                                      searchQuery: value);
                                },
                                onChange: (value) {
                                  // Optionally debounce and call

                                  if (value.trim().isEmpty) {
                                    log("selected33${controller.selectedDate.value}");
                                    controller.getSavedJournals(
                                        date: controller.selectedDate.value);
                                  }
                                  ;
                                  controller.getSavedJournals(
                                      searchQuery: value);
                                },
                              ),
                              18.kheightBox,
                              Row(
                                children: [
                                  Text(
                                    'My Journals',
                                    style: TextStyleUtil.genSans500(
                                        fontSize: 21.ksp),
                                  ),
                                  Spacer(),
                                  CalenderTabBar(
                                    backgroundColor: context.lightBrand3Color,
                                    selectedTabColor: context.lightBrand2Color,
                                    tabController: controller.tabController,
                                    title1: "",
                                    title2: "",
                                    labelColor:
                                        ColorUtil(context).lightBrand3Color,
                                    unselectedLabelColor:
                                        ColorUtil(context).white,
                                    height: MediaQuery.of(context).size.height *
                                        0.043,
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                  ),
                                ],
                              ),
                              6.kheightBox,
                              Obx(() => Text(
                                    'Total journals this year - ${controller.totalJournal.value}',
                                    style: TextStyleUtil.genSans400(
                                        fontSize: 10.5.ksp),
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
                                CustomCalendarSection(),
                              // If it’s “Week” you could instead show WeekCalenderRow()
                              if (controller.currentCatenderIndex.value == 0)
                                WeekCalenderRow(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // ── 2) PIN THE TAB BAR at the bottom of the AppBar ──
                ),
              )
            ],

            // ── 3) THE SCROLLABLE BODY ──
            body: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              return TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: controller.calanderTabController,
                children: [
                  // ── WEEK TAB ──
                  // If you need it scrollable, wrap in ListView/SingleChildScrollView
                  Obx(() {
                    if (controller.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    }
                    final items = controller.groupedList;
                    if (items.isEmpty) {
                      return Center(
                        child: Text(
                          'No journal entries for this date',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      );
                    }

                    return Container(
                        height: context.height,
                        child: ListView.builder(
                          itemCount: items.length,
                          padding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 20),
                          itemBuilder: (context, index) {
                            final item = items[index];

                            if (item is DateHeader) {
                              final dateStr = DateFormat.yMMMMd()
                                  .format(item.date); // e.g. June 25, 2025
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Text(
                                  dateStr,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              );
                            }
                            final nextIsHeader = (index + 1 < items.length &&
                                items[index + 1] is DateHeader);
                            final lineHeight = nextIsHeader ? 40.0 : 80.0;
                            final entry = (item as EntryItem).entry;
                            final isLast = index == items.length - 1;
                            return Slidable(
                              key: ValueKey(entry.id), // or index

                              // 1) Define the slide‐pane that appears on the left

                              // 2) Define the slide‐pane that appears on the right
                              endActionPane: ActionPane(
                                motion: const DrawerMotion(),
                                // tweak this to make room for your two‐icon column
                                extentRatio: 0.25,
                                children: [
                                  CustomSlidableAction(
                                    onPressed: (_) async {
                                      final confirmed =
                                          await Get.dialog(AlertDialog(
                                        title: Text("Confirm Delete"),
                                        content: Text(
                                            "Are you sure you want to delete this journal entry?"),
                                        actions: [
                                          TextButton(
                                              onPressed: () =>
                                                  Get.back(result: false),
                                              child: Text("Cancel")),
                                          TextButton(
                                              onPressed: () =>
                                                  Get.back(result: true),
                                              child: Text("Delete")),
                                        ],
                                      ));

                                      if (confirmed == true) {
                                        controller.onJournalDelete(entry);
                                      }
                                    },
                                    backgroundColor: Colors.transparent,
                                    foregroundColor: Colors.transparent,
                                    padding: EdgeInsets.zero,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: 64.kw,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle,
                                            ),
                                            child: CommonImageView(
                                              svgPath: ImageConstant.deleteIcon,
                                              fit: BoxFit.none,
                                            ),
                                          ),
                                        ),
                                        8.kheightBox,
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () =>
                                                controller.onEdit(entry),
                                            child: Container(
                                              width: 64.kw,
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                shape: BoxShape.circle,
                                              ),
                                              child: CommonImageView(
                                                svgPath: ImageConstant.editIcon,
                                                fit: BoxFit.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ).paddingOnly(bottom: 16),
                                  )
                                  // SlidableAction(
                                  //   onPressed: (_) => controller.onJournalDelete(entry),
                                  //   backgroundColor: Colors.red,
                                  //   foregroundColor: Colors.white,
                                  //   icon: Icons.delete,
                                  //   label: 'Delete',
                                  // ),
                                ],
                              ),

                              // 3) Your actual row
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // ● Timeline line + time
                                  Column(
                                    children: [
                                      Text(
                                        entry.formattedTime,
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

                                  // ● Card
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.UPDATE_TIMELINE,
                                            arguments: {
                                              'id': entry.id,
                                              'viewOnly': true
                                            });
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 20),
                                        padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade300,
                                              blurRadius: 6,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CommonImageView(
                                              svgPath: controller
                                                  .getMoodImagePath(entry.mood),
                                            ),
                                            SizedBox(width: 10),
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
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          horizontal: 8,
                                                          vertical: 4,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: controller
                                                              .getMoodColor(
                                                                  entry.mood),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: Text(
                                                          entry.mood
                                                                  .capitalizeFirst ??
                                                              '',
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
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                        // ListView.builder(
                        //   itemCount: controller.entries.length,
                        //   padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                        //   itemBuilder: (context, index) {
                        //     final entry = controller.entries[index];
                        //     final isLast = index == controller.entries.length - 1;
                        //
                        //     return Row(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         // Timeline line and time
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
                        //               color: Colors.green,
                        //             ),
                        //           ],
                        //         ),
                        //         SizedBox(width: 12),
                        //
                        //         // Card
                        //         Expanded(
                        //           child: Container(
                        //             margin: EdgeInsets.only(bottom: 20),
                        //             padding: EdgeInsets.all(12),
                        //             decoration: BoxDecoration(
                        //               color: Colors.white,
                        //               borderRadius: BorderRadius.circular(14),
                        //               boxShadow: [
                        //                 BoxShadow(
                        //                   color: Colors.grey.shade300,
                        //                   blurRadius: 6,
                        //                   offset: Offset(0, 3),
                        //                 ),
                        //               ],
                        //             ),
                        //             child: Row(
                        //               crossAxisAlignment: CrossAxisAlignment.start,
                        //               children: [
                        //                 // Image
                        //                 CommonImageView(
                        //                   svgPath: controller.getMoodImagePath(entry.mood), // Dynamic image based on mood
                        //                 ),
                        //                 SizedBox(width: 10),
                        //                 // Text content
                        //                 Expanded(
                        //                   child: Column(
                        //                     crossAxisAlignment: CrossAxisAlignment.start,
                        //                     children: [
                        //                       Row(
                        //                         children: [
                        //                           Expanded(
                        //                             child: Text(
                        //                               entry.title,
                        //                               style: TextStyle(
                        //                                 fontWeight: FontWeight.w600,
                        //                               ),
                        //                             ),
                        //                           ),
                        //                           Container(
                        //                             padding: EdgeInsets.symmetric(
                        //                               horizontal: 8,
                        //                               vertical: 4,
                        //                             ),
                        //                             decoration: BoxDecoration(
                        //                               color: controller.getMoodColor(entry.mood),
                        //                               borderRadius: BorderRadius.circular(20),
                        //                             ),
                        //                             child: Text(
                        //                               entry.mood,
                        //                               style: TextStyle(
                        //                                 fontSize: 10,
                        //                                 color: Colors.white,
                        //                               ),
                        //                             ),
                        //                           ),
                        //                         ],
                        //                       ),
                        //                       SizedBox(height: 4),
                        //                       Text(
                        //                         entry.description,
                        //                         style: TextStyle(
                        //                           color: Colors.grey[600],
                        //                           fontSize: 13,
                        //                         ),
                        //                         maxLines: 2,
                        //                         overflow: TextOverflow.ellipsis,
                        //                       ),
                        //
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
                        );
                  }),

                  // ── MONTH TAB: journal list (scrolls to collapse header) ──
                  Obx(() {
                    if (controller.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (controller.entries.isEmpty) {
                      return Center(
                        child: Text(
                          'No journal entries for this date',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      );
                    }

                    return Container(
                        height: context.height,
                        child: ListView.builder(
                          itemCount: controller.entries.length,
                          padding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 20),
                          itemBuilder: (context, index) {
                            final entry = controller.entries[index];
                            final isLast =
                                index == controller.entries.length - 1;

                            return Slidable(
                              key: ValueKey(entry.id), // or index

                              // 1) Define the slide‐pane that appears on the left

                              // 2) Define the slide‐pane that appears on the right
                              endActionPane: ActionPane(
                                motion: const DrawerMotion(),
                                // tweak this to make room for your two‐icon column
                                extentRatio: 0.25,
                                children: [
                                  CustomSlidableAction(
                                    onPressed: (_) async {
                                      final confirmed =
                                          await Get.dialog(AlertDialog(
                                        title: Text("Confirm Delete"),
                                        content: Text(
                                            "Are you sure you want to delete this journal entry?"),
                                        actions: [
                                          TextButton(
                                              onPressed: () =>
                                                  Get.back(result: false),
                                              child: Text("Cancel")),
                                          TextButton(
                                              onPressed: () =>
                                                  Get.back(result: true),
                                              child: Text("Delete")),
                                        ],
                                      ));

                                      if (confirmed == true) {
                                        controller.onJournalDelete(entry);
                                      }
                                    },
                                    backgroundColor: Colors.transparent,
                                    foregroundColor: Colors.transparent,
                                    padding: EdgeInsets.zero,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: 64.kw,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle,
                                            ),
                                            child: CommonImageView(
                                              svgPath: ImageConstant.deleteIcon,
                                              fit: BoxFit.none,
                                            ),
                                          ),
                                        ),
                                        8.kheightBox,
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () =>
                                                controller.onEdit(entry),
                                            child: Container(
                                              width: 64.kw,
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                shape: BoxShape.circle,
                                              ),
                                              child: CommonImageView(
                                                svgPath: ImageConstant.editIcon,
                                                fit: BoxFit.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ).paddingOnly(bottom: 16),
                                  )
                                  // SlidableAction(
                                  //   onPressed: (_) => controller.onJournalDelete(entry),
                                  //   backgroundColor: Colors.red,
                                  //   foregroundColor: Colors.white,
                                  //   icon: Icons.delete,
                                  //   label: 'Delete',
                                  // ),
                                ],
                              ),

                              // 3) Your actual row
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // ● Timeline line + time
                                  Column(
                                    children: [
                                      Text(
                                        entry.formattedTime,
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

                                  // ● Card
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CommonImageView(
                                            svgPath: controller
                                                .getMoodImagePath(entry.mood),
                                          ),
                                          SizedBox(width: 10),
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
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 4,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: controller
                                                            .getMoodColor(
                                                                entry.mood),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      child: Text(
                                                        entry.mood
                                                                .capitalizeFirst ??
                                                            '',
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
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                        // ListView.builder(
                        //   itemCount: controller.entries.length,
                        //   padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                        //   itemBuilder: (context, index) {
                        //     final entry = controller.entries[index];
                        //     final isLast = index == controller.entries.length - 1;
                        //
                        //     return Row(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         // Timeline line and time
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
                        //               color: Colors.green,
                        //             ),
                        //           ],
                        //         ),
                        //         SizedBox(width: 12),
                        //
                        //         // Card
                        //         Expanded(
                        //           child: Container(
                        //             margin: EdgeInsets.only(bottom: 20),
                        //             padding: EdgeInsets.all(12),
                        //             decoration: BoxDecoration(
                        //               color: Colors.white,
                        //               borderRadius: BorderRadius.circular(14),
                        //               boxShadow: [
                        //                 BoxShadow(
                        //                   color: Colors.grey.shade300,
                        //                   blurRadius: 6,
                        //                   offset: Offset(0, 3),
                        //                 ),
                        //               ],
                        //             ),
                        //             child: Row(
                        //               crossAxisAlignment: CrossAxisAlignment.start,
                        //               children: [
                        //                 // Image
                        //                 CommonImageView(
                        //                   svgPath: controller.getMoodImagePath(entry.mood), // Dynamic image based on mood
                        //                 ),
                        //                 SizedBox(width: 10),
                        //                 // Text content
                        //                 Expanded(
                        //                   child: Column(
                        //                     crossAxisAlignment: CrossAxisAlignment.start,
                        //                     children: [
                        //                       Row(
                        //                         children: [
                        //                           Expanded(
                        //                             child: Text(
                        //                               entry.title,
                        //                               style: TextStyle(
                        //                                 fontWeight: FontWeight.w600,
                        //                               ),
                        //                             ),
                        //                           ),
                        //                           Container(
                        //                             padding: EdgeInsets.symmetric(
                        //                               horizontal: 8,
                        //                               vertical: 4,
                        //                             ),
                        //                             decoration: BoxDecoration(
                        //                               color: controller.getMoodColor(entry.mood),
                        //                               borderRadius: BorderRadius.circular(20),
                        //                             ),
                        //                             child: Text(
                        //                               entry.mood,
                        //                               style: TextStyle(
                        //                                 fontSize: 10,
                        //                                 color: Colors.white,
                        //                               ),
                        //                             ),
                        //                           ),
                        //                         ],
                        //                       ),
                        //                       SizedBox(height: 4),
                        //                       Text(
                        //                         entry.description,
                        //                         style: TextStyle(
                        //                           color: Colors.grey[600],
                        //                           fontSize: 13,
                        //                         ),
                        //                         maxLines: 2,
                        //                         overflow: TextOverflow.ellipsis,
                        //                       ),
                        //
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
                        );
                  }),
                ],
              );
            }),
          ),
        ),
        // Column(
        //   children: [
        //
        //
        //
        //     JournalAppBar(tabController: controller.calanderTabController),
        //     Expanded(
        //       child: Obx(() {
        //         if (controller.isLoading.value) {
        //           return Center(child: CircularProgressIndicator());
        //         }
        //
        //         if (controller.entries.isEmpty) {
        //           return Center(
        //             child: Text(
        //               'No journal entries for this date',
        //               style: TextStyle(
        //                 color: Colors.grey[600],
        //                 fontSize: 16,
        //               ),
        //             ),
        //           );
        //         }
        //
        //         return Container(
        //           height: context.height,
        //           child: ListView.builder(
        //             itemCount: controller.entries.length,
        //             padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        //             itemBuilder: (context, index) {
        //               final entry = controller.entries[index];
        //               final isLast = index == controller.entries.length - 1;
        //
        //               return Slidable(
        //                 key: ValueKey(entry.id), // or index
        //
        //                 // 1) Define the slide‐pane that appears on the left
        //
        //
        //                 // 2) Define the slide‐pane that appears on the right
        //                 endActionPane: ActionPane(
        //                   motion: const DrawerMotion(),
        //                   // tweak this to make room for your two‐icon column
        //                   extentRatio: 0.25,
        //                   children: [
        //                     CustomSlidableAction(
        //                       onPressed: (_) async {
        //                         final confirmed = await Get.dialog(AlertDialog(
        //                           title: Text("Confirm Delete"),
        //                           content: Text("Are you sure you want to delete this journal entry?"),
        //                           actions: [
        //                             TextButton(onPressed: () => Get.back(result: false), child: Text("Cancel")),
        //                             TextButton(onPressed: () => Get.back(result: true), child: Text("Delete")),
        //                           ],
        //                         ));
        //
        //                         if (confirmed == true) {
        //                           controller.onJournalDelete(entry);
        //                         }
        //                       },
        //                       backgroundColor: Colors.transparent,
        //                       foregroundColor: Colors.transparent,
        //                       padding: EdgeInsets.zero,
        //                       child: Column(
        //                         mainAxisAlignment: MainAxisAlignment.center,
        //                         children: [
        //                           Expanded(
        //                             child: Container(
        //
        //                               width: 64.kw,
        //                               decoration: BoxDecoration(
        //                                 color: Colors.red,
        //                                 shape: BoxShape.circle,
        //                               ),
        //                               child: CommonImageView(svgPath: ImageConstant.deleteIcon,fit: BoxFit.none,),
        //                             ),
        //                           ),
        //                           8.kheightBox,
        //                           Expanded(
        //                             child: GestureDetector(
        //                               onTap: () => controller.onEdit(entry),
        //                               child: Container(
        //
        //                                 width: 64.kw,
        //                                 decoration: BoxDecoration(
        //                                   color: Colors.green,
        //                                   shape: BoxShape.circle,
        //                                 ),
        //                                 child: CommonImageView(svgPath: ImageConstant.editIcon,fit: BoxFit.none,),
        //                               ),
        //                             ),
        //                           ),
        //                         ],
        //                       ).paddingOnly(bottom: 16),
        //                     )
        //                     // SlidableAction(
        //                     //   onPressed: (_) => controller.onJournalDelete(entry),
        //                     //   backgroundColor: Colors.red,
        //                     //   foregroundColor: Colors.white,
        //                     //   icon: Icons.delete,
        //                     //   label: 'Delete',
        //                     // ),
        //                   ],
        //                 ),
        //
        //                 // 3) Your actual row
        //                 child: Row(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     // ● Timeline line + time
        //                     Column(
        //                       children: [
        //                         Text(
        //                           entry.time,
        //                           style: TextStyle(
        //                             fontWeight: FontWeight.bold,
        //                             color: Colors.grey[700],
        //                           ),
        //                         ),
        //                         Container(
        //                           width: 2,
        //                           height: isLast ? 40 : 80,
        //                           color: Colors.green,
        //                         ),
        //                       ],
        //                     ),
        //                     SizedBox(width: 12),
        //
        //                     // ● Card
        //                     Expanded(
        //                       child: Container(
        //                         margin: EdgeInsets.only(bottom: 20),
        //                         padding: EdgeInsets.all(12),
        //                         decoration: BoxDecoration(
        //                           color: Colors.white,
        //                           borderRadius: BorderRadius.circular(14),
        //                           boxShadow: [
        //                             BoxShadow(
        //                               color: Colors.grey.shade300,
        //                               blurRadius: 6,
        //                               offset: Offset(0, 3),
        //                             ),
        //                           ],
        //                         ),
        //                         child: Row(
        //                           crossAxisAlignment: CrossAxisAlignment.start,
        //                           children: [
        //                             CommonImageView(
        //                               svgPath: controller.getMoodImagePath(entry.mood),
        //                             ),
        //                             SizedBox(width: 10),
        //                             Expanded(
        //                               child: Column(
        //                                 crossAxisAlignment: CrossAxisAlignment.start,
        //                                 children: [
        //                                   Row(
        //                                     children: [
        //                                       Expanded(
        //                                         child: Text(
        //                                           entry.title,
        //                                           style: TextStyle(
        //                                             fontWeight: FontWeight.w600,
        //                                           ),
        //                                         ),
        //                                       ),
        //                                       Container(
        //                                         padding: EdgeInsets.symmetric(
        //                                           horizontal: 8,
        //                                           vertical: 4,
        //                                         ),
        //                                         decoration: BoxDecoration(
        //                                           color: controller.getMoodColor(entry.mood),
        //                                           borderRadius: BorderRadius.circular(20),
        //                                         ),
        //                                         child: Text(
        //                                           entry.mood,
        //                                           style: TextStyle(
        //                                             fontSize: 10,
        //                                             color: Colors.white,
        //                                           ),
        //                                         ),
        //                                       ),
        //                                     ],
        //                                   ),
        //                                   SizedBox(height: 4),
        //                                   Text(
        //                                     entry.description,
        //                                     style: TextStyle(
        //                                       color: Colors.grey[600],
        //                                       fontSize: 13,
        //                                     ),
        //                                     maxLines: 2,
        //                                     overflow: TextOverflow.ellipsis,
        //                                   ),
        //                                 ],
        //                               ),
        //                             ),
        //                           ],
        //                         ),
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               );
        //             },
        //           )
        //           // ListView.builder(
        //           //   itemCount: controller.entries.length,
        //           //   padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        //           //   itemBuilder: (context, index) {
        //           //     final entry = controller.entries[index];
        //           //     final isLast = index == controller.entries.length - 1;
        //           //
        //           //     return Row(
        //           //       crossAxisAlignment: CrossAxisAlignment.start,
        //           //       children: [
        //           //         // Timeline line and time
        //           //         Column(
        //           //           children: [
        //           //             Text(
        //           //               entry.time,
        //           //               style: TextStyle(
        //           //                 fontWeight: FontWeight.bold,
        //           //                 color: Colors.grey[700],
        //           //               ),
        //           //             ),
        //           //             Container(
        //           //               width: 2,
        //           //               height: isLast ? 40 : 80,
        //           //               color: Colors.green,
        //           //             ),
        //           //           ],
        //           //         ),
        //           //         SizedBox(width: 12),
        //           //
        //           //         // Card
        //           //         Expanded(
        //           //           child: Container(
        //           //             margin: EdgeInsets.only(bottom: 20),
        //           //             padding: EdgeInsets.all(12),
        //           //             decoration: BoxDecoration(
        //           //               color: Colors.white,
        //           //               borderRadius: BorderRadius.circular(14),
        //           //               boxShadow: [
        //           //                 BoxShadow(
        //           //                   color: Colors.grey.shade300,
        //           //                   blurRadius: 6,
        //           //                   offset: Offset(0, 3),
        //           //                 ),
        //           //               ],
        //           //             ),
        //           //             child: Row(
        //           //               crossAxisAlignment: CrossAxisAlignment.start,
        //           //               children: [
        //           //                 // Image
        //           //                 CommonImageView(
        //           //                   svgPath: controller.getMoodImagePath(entry.mood), // Dynamic image based on mood
        //           //                 ),
        //           //                 SizedBox(width: 10),
        //           //                 // Text content
        //           //                 Expanded(
        //           //                   child: Column(
        //           //                     crossAxisAlignment: CrossAxisAlignment.start,
        //           //                     children: [
        //           //                       Row(
        //           //                         children: [
        //           //                           Expanded(
        //           //                             child: Text(
        //           //                               entry.title,
        //           //                               style: TextStyle(
        //           //                                 fontWeight: FontWeight.w600,
        //           //                               ),
        //           //                             ),
        //           //                           ),
        //           //                           Container(
        //           //                             padding: EdgeInsets.symmetric(
        //           //                               horizontal: 8,
        //           //                               vertical: 4,
        //           //                             ),
        //           //                             decoration: BoxDecoration(
        //           //                               color: controller.getMoodColor(entry.mood),
        //           //                               borderRadius: BorderRadius.circular(20),
        //           //                             ),
        //           //                             child: Text(
        //           //                               entry.mood,
        //           //                               style: TextStyle(
        //           //                                 fontSize: 10,
        //           //                                 color: Colors.white,
        //           //                               ),
        //           //                             ),
        //           //                           ),
        //           //                         ],
        //           //                       ),
        //           //                       SizedBox(height: 4),
        //           //                       Text(
        //           //                         entry.description,
        //           //                         style: TextStyle(
        //           //                           color: Colors.grey[600],
        //           //                           fontSize: 13,
        //           //                         ),
        //           //                         maxLines: 2,
        //           //                         overflow: TextOverflow.ellipsis,
        //           //                       ),
        //           //
        //           //                     ],
        //           //                   ),
        //           //                 ),
        //           //               ],
        //           //             ),
        //           //           ),
        //           //         ),
        //           //       ],
        //           //     );
        //           //   },
        //           // ),
        //         );
        //       }),
        //     ),
        //     // Expanded(
        //     //   child: Container(
        //     //     height: context.height,
        //     //     child: ListView.builder(
        //     //       itemCount: controller.entries.length,
        //     //       padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        //     //       itemBuilder: (context, index) {
        //     //         final entry = controller.entries[index];
        //     //         final isLast = index == controller.entries.length - 1;
        //     //
        //     //         return Row(
        //     //           crossAxisAlignment: CrossAxisAlignment.start,
        //     //           children: [
        //     //             // Timeline line and time
        //     //             Column(
        //     //               children: [
        //     //                 Text(
        //     //                   entry.time,
        //     //                   style: TextStyle(
        //     //                     fontWeight: FontWeight.bold,
        //     //                     color: Colors.grey[700],
        //     //                   ),
        //     //                 ),
        //     //                 Container(
        //     //                   width: 2,
        //     //                   height: isLast ? 40 : 80,
        //     //                   color: Colors.green,
        //     //                 ),
        //     //               ],
        //     //             ),
        //     //             SizedBox(width: 12),
        //     //
        //     //             // Card
        //     //             Expanded(
        //     //               child: Container(
        //     //                 margin: EdgeInsets.only(bottom: 20),
        //     //                 padding: EdgeInsets.all(12),
        //     //                 decoration: BoxDecoration(
        //     //                   color: Colors.white,
        //     //                   borderRadius: BorderRadius.circular(14),
        //     //                   boxShadow: [
        //     //                     BoxShadow(
        //     //                       color: Colors.grey.shade300,
        //     //                       blurRadius: 6,
        //     //                       offset: Offset(0, 3),
        //     //                     ),
        //     //                   ],
        //     //                 ),
        //     //                 child: Row(
        //     //                   crossAxisAlignment: CrossAxisAlignment.start,
        //     //                   children: [
        //     //                     // Image
        //     //                     //
        //     //                     CommonImageView(
        //     //                       svgPath: ImageConstant.happyMood,
        //     //                     ),
        //     //                     SizedBox(width: 10),
        //     //                     // Text content
        //     //                     Expanded(
        //     //                       child: Column(
        //     //                         crossAxisAlignment:
        //     //                             CrossAxisAlignment.start,
        //     //                         children: [
        //     //                           Row(
        //     //                             children: [
        //     //                               Expanded(
        //     //                                 child: Text(
        //     //                                   entry.title,
        //     //                                   style: TextStyle(
        //     //                                     fontWeight: FontWeight.w600,
        //     //                                   ),
        //     //                                 ),
        //     //                               ),
        //     //                               Container(
        //     //                                 padding: EdgeInsets.symmetric(
        //     //                                   horizontal: 8,
        //     //                                   vertical: 4,
        //     //                                 ),
        //     //                                 decoration: BoxDecoration(
        //     //                                   color: getMoodColor(entry.mood),
        //     //                                   borderRadius:
        //     //                                       BorderRadius.circular(20),
        //     //                                 ),
        //     //                                 child: Text(
        //     //                                   entry.mood,
        //     //                                   style: TextStyle(
        //     //                                     fontSize: 10,
        //     //                                     color: Colors.white,
        //     //                                   ),
        //     //                                 ),
        //     //                               ),
        //     //                             ],
        //     //                           ),
        //     //                           SizedBox(height: 4),
        //     //                           Text(
        //     //                             entry.description,
        //     //                             style: TextStyle(
        //     //                               color: Colors.grey[600],
        //     //                               fontSize: 13,
        //     //                             ),
        //     //                           ),
        //     //                         ],
        //     //                       ),
        //     //                     ),
        //     //                   ],
        //     //                 ),
        //     //               ),
        //     //             ),
        //     //           ],
        //     //         );
        //     //       },
        //     //     ),
        //     //   ),
        //     // ),
        //   ],
        // ),
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
//
// class CustomCalendarSection extends StatefulWidget {
//   const CustomCalendarSection({super.key});
//
//   @override
//   State<CustomCalendarSection> createState() => _CustomCalendarSectionState();
// }
//
// class _CustomCalendarSectionState extends State<CustomCalendarSection> {
//   DateTime focusedDay = DateTime.now();
//   DateTime? selectedDay;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // Horizontal Dates List (top part like in POIV)
//         _buildWeekDateRow(),
//
//         const SizedBox(height: 16),
//
//         // Full Calendar View
//         TableCalendar(
//           firstDay: DateTime.utc(2020, 1, 1),
//           lastDay: DateTime.utc(2030, 12, 31),
//           focusedDay: focusedDay,
//           selectedDayPredicate: (day) => isSameDay(selectedDay, day),
//           onDaySelected: (selected, focused) {
//             setState(() {
//               selectedDay = selected;
//               focusedDay = focused;
//             });
//           },
//           calendarStyle: const CalendarStyle(
//             todayDecoration: BoxDecoration(
//               color: Colors.green,
//               shape: BoxShape.circle,
//             ),
//             selectedDecoration: BoxDecoration(
//               color: Colors.green,
//               shape: BoxShape.circle,
//             ),
//           ),
//           headerVisible: false,
//           daysOfWeekVisible: false,
//         ),
//       ],
//     );
//   }
//
//   Widget _buildWeekDateRow() {
//     final startOfWeek = DateTime.now().subtract(
//       Duration(days: DateTime.now().weekday - 1),
//     );
//     final dates = List.generate(
//       7,
//       (index) => startOfWeek.add(Duration(days: index)),
//     );
//
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children:
//             dates.map((date) {
//               final isSelected = isSameDay(date, selectedDay ?? DateTime.now());
//               return GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     selectedDay = date;
//                     focusedDay = date;
//                   });
//                 },
//                 child: Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 6),
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 14,
//                     vertical: 10,
//                   ),
//                   decoration: BoxDecoration(
//                     color: isSelected ? Colors.green : Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(color: Colors.green),
//                   ),
//                   child: Column(
//                     children: [
//                       Text(
//                         DateFormat.E().format(date), // e.g., Mon
//                         style: TextStyle(
//                           color: isSelected ? Colors.white : Colors.green,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         date.day.toString(), // e.g., 26
//                         style: TextStyle(
//                           color: isSelected ? Colors.white : Colors.green,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }).toList(),
//       ),
//     );
//   }
// }
