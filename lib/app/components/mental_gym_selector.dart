import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/models/community_details_model.dart';
import 'package:kamelion/app/models/mental_gym_category_model.dart';
import 'package:kamelion/app/modules/community/controllers/community_controller.dart';
import 'package:kamelion/app/modules/mentalGym/controllers/mental_gym_controller.dart';
import 'package:kamelion/app/modules/navigationBar/controllers/navigation_bar_controller.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';

class MentalGymSelector extends StatelessWidget {
  MentalGymSelector({
    super.key,
    required this.mentalGymList,
    this.title,
    this.showViewAll,
    this.isMentalGym = true,
  });

  List<MentalGymCategoryModel> mentalGymList;
  String? title;
  bool? showViewAll = true;
  bool isMentalGym;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 0.0.ksp),
              child: Text(
                title ?? LocaleKeys.mental_gyms.tr,
                style: TextStyleUtil.genSans600(
                  fontSize: 16.ksp,
                  color: ColorUtil(context).black,
                ),
              ),
            ),
            (showViewAll ?? true)
                ? Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.find<MentalGymController>().changeTab(0);
                          Get.find<NavigationBarController>().changePage(1);
                        },
                        child: Text(
                          LocaleKeys.view_all.tr,
                          style: TextStyleUtil.genSans500(
                            fontSize: 11.ksp,
                            color: ColorUtil(context).brandColor1,
                            height: 1.2,
                          ),
                        ),
                      ),

                    ],
                  )
                : Container(),
          ],
        ),
        16.kheightBox,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: mentalGymList.asMap().entries.map((entry) {
              int index = entry.key;
              var item = entry.value;
              return Padding(
                padding:  EdgeInsets.only(left: 16.kw),
                child: InkWell(
                  onTap: () async {
                    if (!isMentalGym) {
                      Get.find<CommunityController>().selectedScreenIndex.value =
                          3;
                      Get.find<CommunityController>().getCommunitiesByCategory(
                        id: item.sId ?? "",
                        categoryName: item.title ?? "",
                        index: index + 3,
                      );
                    } else {
                      Get.find<NavigationBarController>().selectedIndex.value = 1;
                      await Get.find<MentalGymController>()
                          .getMentalGymByCategory(categoryId: item.sId ?? "");
                      Get.find<MentalGymController>().viewAllTitle.value =
                          item.title ?? "";
                      Get.find<MentalGymController>().changeTab(index + 5);
                    }
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 64.kw,
                        height: 64.kw,
                        decoration: BoxDecoration(
                          color: Colors.red,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(item.image ?? ''),
                                fit: BoxFit.fill)),
                      ),
                      8.kheightBox,
                      SizedBox(
                        width: 64.kw,
                        child: Center(
                          child: Text(
                            item.title ?? "",
                            style: TextStyleUtil.genSans600(
                              fontSize: 10.ksp,
                              color: ColorUtil(context).greyScaleText,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
