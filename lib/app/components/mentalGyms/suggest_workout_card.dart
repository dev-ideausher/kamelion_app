import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';

class SuggestedWorkoutCards extends StatelessWidget {
  const SuggestedWorkoutCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0.ksp, vertical: 8.ksp),
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
                  svgPath: ImageConstant.dummyCoverImage,
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
                          "Building Friendships",
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
                          "Social Life",
                          style: TextStyleUtil.genSans400(
                            fontSize: 10.ksp,
                            color: ColorUtil(context).greyDark,
                            height: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.bookmark_outline),
                ],
              ),
            ),
            10.kheightBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.ksp),
              child: Text(
                "Earn Kalikoins",
                style: TextStyleUtil.genSans500(
                  fontSize: 11.ksp,
                  color: ColorUtil(context).brandColor1,
                  height: 1.2,
                ),
              ),
            ),
            10.kheightBox,
          ],
        ),
      ),
    );
  }
}
