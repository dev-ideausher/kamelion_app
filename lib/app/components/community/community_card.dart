import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:kamelion/app/components/avatar.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';

class CommmunityCard extends StatelessWidget {
  CommmunityCard({
    super.key,
    this.onTap,
    required this.ownerName,
    required this.peopleCount,
    required this.title,
    required this.postCount,
    required this.imageURL,
    required this.userAvatarDetails,

    this.review,
  });
  Function()? onTap;
  String title, postCount, peopleCount, ownerName, imageURL, userAvatarDetails;
  String? review;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.0.ksp),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: context.width * 0.9,
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
                      url: imageURL,
                      // svgPath: ImageConstant.dummyCoverImage,
                      height: 110.ksp,
                      width: context.width * 0.9,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: context.width * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.0.ksp,
                            ),
                            child: Text(
                              title,
                              style: TextStyleUtil.genSans400(
                                fontSize: 12.ksp,
                                color: ColorUtil(context).black,
                                height: 1.2,
                              ),
                            ),
                          ),
                          // Spacer(),
                          Column(
                            children: [
                              review == null
                                  ? Container()
                                  : Padding(
                                    padding: EdgeInsets.only(
                                      right: 10.0.ksp,
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.ksp,
                                        vertical: 2.ksp,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            review == "pending"
                                                ? ColorUtil(
                                                  context,
                                                ).lighPitchBg
                                                : review == "rejected"
                                                ? ColorUtil(
                                                  context,
                                                ).lightRedBg2
                                                : ColorUtil(
                                                  context,
                                                ).lightGreenBg2,
                                        borderRadius:
                                            BorderRadius.circular(20.ksp),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          5.kwidthBox,
                                          Padding(
                                            padding: EdgeInsets.only(
                                              right: 0.0.ksp,
                                            ),
                                            child: Text(
                                              review == "pending"
                                                  ? "Under review"
                                                  : review == "rejected"
                                                  ? "Rejected"
                                                  : "Approved",
                                              style: TextStyleUtil.genSans500(
                                                fontSize: 10.ksp,
                                                color:
                                                    review == "pending"
                                                        ? ColorUtil(
                                                          context,
                                                        ).darkRedText
                                                        : review ==
                                                            "rejected"
                                                        ? ColorUtil(
                                                          context,
                                                        ).redBg2
                                                        : ColorUtil(
                                                          context,
                                                        ).greyBg2,

                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          5.kwidthBox,
                                        ],
                                      ),
                                    ),
                                  ),

                              review == null
                                  ? Row(mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Avatar().showAvatar(
                                        avatarDetails: userAvatarDetails,
                                        bgColor: context.blueBg,
                                        context: context,
                                        radius: 9.5.ksp,
                                      ),
                                      // CircleAvatar(
                                      //   radius: 9.ksp,
                                      //   backgroundImage: NetworkImage(
                                      //     // imageURL,
                                      //     "https://thumbs.dreamstime.com/b/vector-illustration-avatar-dummy-logo-collection-image-icon-stock-isolated-object-set-symbol-web-137160339.jpg",
                                      //     // "https://upload.wikimedia.org/wikipedia/commons/thumb/9/93/Kim_Jong-un_2024.jpg/250px-Kim_Jong-un_2024.jpg",
                                      //   ),
                                      // ),
                                      6.kwidthBox,
                                      Text(
                                        ownerName,
                                        style: TextStyleUtil.genSans500(
                                          fontSize: 10.ksp,
                                          color:
                                              ColorUtil(context).greyDark,
                                          height: 1.2,
                                        ),
                                      ),
                                      10.kwidthBox,
                                    ],
                                  )
                                  : Container(),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.0.ksp,
                          vertical: 2.ksp,
                        ),
                        child: Text(
                          "$postCount Posts • $peopleCount People",
                          style: TextStyleUtil.genSans400(
                            fontSize: 10.ksp,
                            color: ColorUtil(context).greyDark,
                            height: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                10.kheightBox,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 11.0.ksp),
                  child: Container(
                    // width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.ksp,
                      vertical: 4.ksp,
                    ),
                    decoration: BoxDecoration(
                      color: context.lightPurple, // Background color
                      borderRadius: BorderRadius.circular(
                        8.ksp,
                      ), // Rounded corners
                    ),
                    child: Text(
                      "Active Workouts",
                      style: TextStyleUtil.genSans400(
                        fontSize: 10.ksp,
                        color: context.darkPurple,
                      ),
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
