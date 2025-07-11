import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/components/center_float_button.dart';
import 'package:kamelion/app/components/mentalGyms/mental_gyms_appbar.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';
import '../controllers/mental_gym_controller.dart';

class MentalGymView extends GetView<MentalGymController> {
  MentalGymView({super.key});
  final MentalGymController controller = Get.put(MentalGymController());
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return GetBuilder<MentalGymController>(
        builder: (controller) {
          return controller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(color: context.brandColor1),
                )
              : Scaffold(
                  body: Column(
                    children: [
                      MentalGymsAppBar(),
                      Expanded(
                        child: RefreshIndicator(
                          color: context.brandColor1,
                          onRefresh: () async {
                            await controller.getMentalGymCategiries();
                            await controller.getAllMentalGym();
                            await controller.getActiveMentalGym();
                            await controller.getSuggestedMentalGym();
                            await controller.getCompletedMentalGym();
                            await controller
                                .getMentalGymCounts(); // your refresh logic
                          },
                          child: SingleChildScrollView(
                            controller: Get.find<MentalGymController>()
                                .scrollController,
                            child: Column(
                              children: [
                                16.kheightBox,
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      8.kwidthBox,
                                      InkWell(
                                        onTap: () {
                                          controller.changeTab(0);
                                        },
                                        child: _buildTag(
                                          "Mental Gyms",
                                          context,
                                          controller
                                                  .selectedScreenIndex.value ==
                                              0,
                                        ),
                                      ),
                                      8.kwidthBox,
                                      InkWell(
                                        onTap: () {
                                          controller.changeTab(1);
                                        },
                                        child: _buildTag(
                                          "All Mental Gyms",
                                          context,
                                          controller
                                                  .selectedScreenIndex.value ==
                                              1,
                                        ),
                                      ),
                                      8.kwidthBox,
                                      InkWell(
                                        onTap: () {
                                          controller.changeTab(2);
                                        },
                                        child: _buildTag(
                                          "Active Mental Gyms",
                                          context,
                                          controller
                                                  .selectedScreenIndex.value ==
                                              2,
                                        ),
                                      ),
                                      8.kwidthBox,
                                      InkWell(
                                        onTap: () {
                                          controller.changeTab(3);
                                        },
                                        child: _buildTag(
                                          "Suggested Mental Gyms",
                                          context,
                                          controller
                                                  .selectedScreenIndex.value ==
                                              3,
                                        ),
                                      ),
                                      8.kwidthBox,
                                      InkWell(
                                        onTap: () {
                                          controller.changeTab(4);
                                        },
                                        child: _buildTag(
                                          "Popular Mental Gyms",
                                          context,
                                          controller
                                                  .selectedScreenIndex.value ==
                                              4,
                                        ),
                                      ),
                                      8.kwidthBox,
                                      InkWell(
                                        onTap: () {
                                          controller.changeTab(5);
                                        },
                                        child: _buildTag(
                                          "Saved Mental Gyms",
                                          context,
                                          controller
                                                  .selectedScreenIndex.value ==
                                              5,
                                        ),
                                      ),
                                      8.kwidthBox,
                                      InkWell(
                                        onTap: () {
                                          controller.changeTab(6);
                                        },
                                        child: _buildTag(
                                          "Completed Gyms",
                                          context,
                                          controller
                                                  .selectedScreenIndex.value ==
                                              6,
                                        ),
                                      ),
                                      8.kwidthBox,
                                      for (int i = 0;
                                          i <
                                              controller
                                                  .mentalGymCategoryList.length;
                                          i++)
                                        Padding(
                                          padding:
                                              EdgeInsets.only(right: 9.0.ksp),
                                          child: InkWell(
                                            onTap: () {
                                              controller.changeTab(7 + i);
                                            },
                                            child: _buildTag(
                                              controller
                                                      .mentalGymCategoryList[i]
                                                      .title ??
                                                  "",
                                              context,
                                              controller.selectedScreenIndex
                                                      .value ==
                                                  7 + i,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                controller.screensList[
                                    controller.selectedScreenIndex.value],
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        },
      );
    });
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
