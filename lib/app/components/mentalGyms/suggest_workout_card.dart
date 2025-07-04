import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';

class SuggestedWorkoutCards extends StatelessWidget {
  SuggestedWorkoutCards({
    super.key,
    this.onTap,
    this.onSaved,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.isSaved,
  });
  Function()? onTap, onSaved;
  bool isSaved;
  String imageUrl, title, subtitle;
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
          child: Container(
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
                            child: SizedBox(
                              width: 160.ksp,
                              child: Text(
                                subtitle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyleUtil.genSans400(
                                  fontSize: 10.ksp,
                                  color: ColorUtil(context).greyDark,
                                  height: 1.2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: onSaved,
                        child: Icon(
                          isSaved
                              ? Icons.bookmark_outlined
                              : Icons.bookmark_outline,
                        ),
                      ),
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
        ),
      ),
    );
  }
}
