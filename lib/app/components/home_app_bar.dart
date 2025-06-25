import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';
import 'package:get/instance_manager.dart';
import 'package:get/utils.dart';
import 'package:intl/intl.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/modules/home/controllers/home_controller.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/custom_textfield.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';

class HomeAppBar extends StatelessWidget {
  final String userName;

  const HomeAppBar({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('EEE, MMM d yyyy').format(DateTime.now());
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: BoxDecoration(
        color: ColorUtil(context).brandColor1,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// First row: Date and Notification Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  color: ColorUtil(context).white,
                  size: 15.ksp,
                ),
                4.kwidthBox,
                Text(
                  date,
                  style: TextStyleUtil.genSans500(
                    color: ColorUtil(context).white,
                    fontSize: 10.ksp,
                  ),
                ),
                Spacer(),
                Container(
                  // width: 25.ksp,
                  // height: 25.ksp,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent, // background color
                    border: Border.all(
                      color: ColorUtil(context).white, // border color
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(6.ksp),
                      child: Stack(
                        children: [
                          Icon(
                            Icons.notifications_none_outlined,
                            color: ColorUtil(context).white,
                            size: 22.ksp,
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 6.ksp),
                              child: Container(
                                padding: EdgeInsets.all(3.ksp),
                                decoration: BoxDecoration(
                                  color: ColorUtil(context).brandColor3,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '3',
                                  style: TextStyle(
                                    color: ColorUtil(context).white,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            15.kheightBox,

            /// Second row: Profile + Hi + Name
            Row(
              children: [
                // SvgPicture.string(
                //   " <svg viewBox=\"0 0 264 264\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"> <rect width=\"264\" height=\"264\" fill=\"#E5E5E5\"/> <g clip-path=\"url(#clip0_1_2)\"> <path d=\"M132 0C59.1 0 0 59.1 0 132C0 204.9 59.1 264 132 264C204.9 264 264 204.9 264 132C264 59.1 204.9 0 132 0Z\" fill=\"#FFDBB3\"/> <path d=\"M154 132C154 121.046 145.046 112 134 112C122.954 112 114 121.046 114 132C114 142.954 122.954 152 134 152C145.046 152 154 142.954 154 132Z\" fill=\"#673AB7\"/> ... (much more SVG data) ... </g> <defs> <clipPath id=\"clip0_1_2\"> <rect width=\"264\" height=\"264\" fill=\"white\"/> </clipPath> </defs> </svg>",
                //   width: 100, // Set your desired width
                //   height: 100, // Set your desired height
                // ),
                FluttermojiCircleAvatar(
                  backgroundColor: ColorUtil(context).blueBg,
                  radius: 25.ksp,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.hi.tr +
                          " " +
                          userName +
                          LocaleKeys.exclamation.tr,
                      style: TextStyleUtil.genSans500(
                        color: ColorUtil(context).white,
                        fontSize: 22.ksp,
                      ),
                    ),
                    Row(
                      children: [
                        CommonImageView(svgPath: ImageConstant.flameIcon),
                        4.kwidthBox,
                        Text(
                          "6" + " " + LocaleKeys.days_streak.tr,
                          style: TextStyleUtil.genSans400(
                            color: ColorUtil(context).white,
                            fontSize: 12.ksp,
                          ),
                        ),
                        20.kwidthBox,
                        CommonImageView(svgPath: ImageConstant.coinIcon),
                        8.kwidthBox,
                        Text(
                          "1423",
                          style: TextStyleUtil.genSans400(
                            color: ColorUtil(context).white,
                            fontSize: 12.ksp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            16.kheightBox,

            TextFormField(
              // hintText: "Search for anything",
              // fillColor: ColorUtil(context).white,
              // filled: true,
              // prefixIcon: Icon(Icons.search, color: ColorUtil(context).black),
              decoration: InputDecoration(
                hintText: LocaleKeys.search_for_anything.tr,
                filled: true,
                fillColor: ColorUtil(context).white,
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
