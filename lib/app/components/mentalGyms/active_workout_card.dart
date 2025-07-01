import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/models/mental_gyms_details_model.dart';
import 'package:kamelion/app/modules/mentalGym/controllers/mental_gym_controller.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';

class ActiveWorkoutCards extends StatelessWidget {
  ActiveWorkoutCards({
    super.key,
    this.onTap,
    this.onsaved,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.isSaved,
    this.progress = 0,
  });
  Function()? onTap, onsaved;
  String imageUrl, title, subtitle;
  bool isSaved;
  num progress;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0.ksp, vertical: 8.ksp),
      child: InkWell(
        onTap: onTap,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.ksp),
          ),
          color: ColorUtil(context).white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0.ksp),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(4.ksp),
                  ),
                  child: CommonImageView(
                    url: imageUrl,
                    // svgPath: ImageConstant.dummyCoverImage,
                    height: 110.ksp,
                    width: context.width * 0.9,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: context.width * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0.ksp),
                          child: Text(
                            title,
                            style: TextStyleUtil.genSans400(
                              fontSize: 12.ksp,
                              color: ColorUtil(context).black,
                              height: 1.2,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.0.ksp,
                            vertical: 2.ksp,
                          ),
                          child: Text(
                            subtitle,
                            style: TextStyleUtil.genSans400(
                              fontSize: 10.ksp,
                              color: ColorUtil(context).greyDark,
                              height: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: onsaved,
                      child: Icon(
                        isSaved
                            ? Icons.bookmark_outlined
                            : Icons.bookmark_outline,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(11.0.ksp),
                child: Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: (progress / 100),
                        minHeight: 8.ksp,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          context.brandColor1,
                        ),
                        backgroundColor: context.grey,
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0.ksp),
                        ),
                      ),
                    ),
                    12.kwidthBox,
                    Text("$progress% " + LocaleKeys.complete.tr),
                  ],
                ),
              ),
              if (false)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 11.0.ksp),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.ksp,
                      vertical: 4.ksp,
                    ),
                    decoration: BoxDecoration(
                      color: context.lightPinkBg, // Background color
                      borderRadius: BorderRadius.circular(
                        8.ksp,
                      ), // Rounded corners
                    ),
                    child: Text(
                      LocaleKeys.complete_reward_message.tr,
                      style: TextStyleUtil.genSans400(
                        fontSize: 10.ksp,
                        color: context.black,
                      ),
                    ),
                  ),
                ),
              10.kheightBox,
            ],
          ),
        ),
      ),
    );
  }
}
