import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/components/mentalGyms/mental_gyms_appbar.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import '../controllers/mental_gym_controller.dart';

class MentalGymView extends GetView<MentalGymController> {
  MentalGymView({super.key});
  final MentalGymController controller = Get.put(MentalGymController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: Column(
          children: [
            MentalGymsAppBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    16.kheightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          15.kwidthBox,
                          InkWell(
                            onTap: () {
                              controller.selectedScreenIndex.value = 0;
                            },
                            child: _buildTag(
                              "All Workouts",
                              context,
                              controller.selectedScreenIndex.value == 0,
                            ),
                          ),
                          15.kwidthBox,
                          InkWell(
                            onTap: () {
                              controller.selectedScreenIndex.value = 1;
                            },
                            child: _buildTag(
                              "Active Workouts",
                              context,
                              controller.selectedScreenIndex.value == 1,
                            ),
                          ),
                          15.kwidthBox,
                          InkWell(
                            onTap: () {
                              controller.selectedScreenIndex.value = 2;
                            },
                            child: _buildTag(
                              "Saved Workouts",
                              context,
                              controller.selectedScreenIndex.value == 2,
                            ),
                          ),
                          15.kwidthBox,
                        ],
                      ),
                    ),
                    controller.screensList[controller
                        .selectedScreenIndex
                        .value],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildTag(String label, BuildContext context, bool isSelected) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.ksp, vertical: 3.ksp),
    decoration: BoxDecoration(
      color: !isSelected ? context.greyBg2 : context.brandColor1Light,
      borderRadius: BorderRadius.circular(20.ksp),
    ),
    child: Text(
      label,
      style: TextStyleUtil.genSans500(
        fontSize: 10.ksp,
        color: !isSelected ? context.lightBlack : context.brandColor1,
      ),
    ),
  );
}
