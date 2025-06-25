import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/components/activities/support_app_bar.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import '../controllers/support_controller.dart';

class SupportView extends GetView<SupportController> {
  const SupportView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SupportAppBar(),
          Padding(
            padding: EdgeInsets.all(12.0.ksp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.kheightBox,
                Text(
                  'How are you feeling',
                  style: TextStyleUtil.genSans500(
                    fontSize: 15.ksp,
                    color: context.black,
                  ),
                ),
                20.kheightBox,
                ...controller.feelingsList.map(
                  (e) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0.ksp),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(Routes.MIND_FULL_HOURS);
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  e,
                                  style: TextStyleUtil.genSans400(
                                    fontSize: 12.ksp,
                                    color: context.black,
                                  ),
                                ),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios, size: 12.ksp),
                                4.kwidthBox,
                              ],
                            ),
                            2.kheightBox,
                            Divider(color: context.grey),
                            10.kheightBox,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
