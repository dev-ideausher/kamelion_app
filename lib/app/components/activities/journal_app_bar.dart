import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kamelion/app/components/activities/calender.dart';
import 'package:kamelion/app/components/activities/week_calender_row.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/modules/journaling/controllers/journaling_controller.dart';
import 'package:kamelion/app/modules/profile/views/profile_view.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/custom_textfield.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:table_calendar/table_calendar.dart';

class JournalAppBar extends StatelessWidget {
  JournalAppBar({super.key, required this.tabController});
  TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: ColorUtil(context).brandColor1,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.ksp),
            bottomRight: Radius.circular(20.ksp),
          ),
        ),
        height:
            Get.find<JournalingController>().currentCatenderIndex.value == 1
                ? 460.ksp
                : 250.ksp,
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
              // prefixIcon: Icon(Icons.search, color: context.greyDark),
            ),
            18.kheightBox,
            Row(
              children: [
                Text(
                  'My Journals',
                  style: TextStyleUtil.genSans500(fontSize: 21.ksp),
                ),
                Spacer(),
                CalenderTabBar(
                  backgroundColor: context.lightBrand3Color,
                  selectedTabColor: context.lightBrand2Color,
                  tabController: tabController,
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
            Text(
              'Total journals this year - 245',
              style: TextStyleUtil.genSans400(fontSize: 10.5.ksp),
            ),
            10.kheightBox,
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [ WeekCalenderRow(),CustomCalendarSection(),],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CalenderTabBar extends StatelessWidget {
  CalenderTabBar({
    super.key,
    required this.tabController,
    required this.backgroundColor,
    required this.selectedTabColor,
    required this.title1,
    required this.title2,
    required this.labelColor,
    required this.unselectedLabelColor,
    required this.height,
    required this.width,
  });
  TabController tabController;
  String title1, title2;
  double height, width;
  Color selectedTabColor, backgroundColor, unselectedLabelColor, labelColor;
  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<JournalingController>();
    return Center(
      child:Obx((){
        final selected = ctrl.currentCatenderIndex.value;
        return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(24.ksp), // Rounded corners
        ),
        child: TabBar(
          controller: tabController,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(16.ksp),
            color: selectedTabColor,
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          padding: EdgeInsets.all(3.ksp),
          labelColor: labelColor,
          unselectedLabelColor: unselectedLabelColor,
          dividerHeight: 0,
          indicatorWeight: 0,
          labelPadding: EdgeInsets.all(0),
          onTap: (val) {
            Get.find<JournalingController>().currentCatenderIndex.value = val;
          },
          tabs: [
            Tab(
              child: CommonImageView(
                svgPath: ImageConstant.weekCalenderIcon,
                // if this tab is selected, tint with `selectedTabColor`, else grey
                svgColor: selected == 0 ? Colors.green : unselectedLabelColor,
              ),
            ),
            Tab(
              child: CommonImageView(
                svgPath: ImageConstant.calenderIcon,
                svgColor: selected == 1 ? Colors.green  : unselectedLabelColor,
              ),
            ),
          ],
        ),
      );}),
    );
  }
}
