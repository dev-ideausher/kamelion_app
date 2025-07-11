import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';
import 'package:fluttermoji/fluttermojiCustomizer.dart';
import 'package:fluttermoji/fluttermojiFunctions.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:get/utils.dart';
import 'package:intl/intl.dart';
import 'package:kamelion/app/components/avatar.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/modules/createAvatar/views/avatar_name_view.dart';
import 'package:kamelion/app/modules/home/controllers/home_controller.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/custom_textfield.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';
import 'package:kamelion/generated/locales.g.dart';

class HomeAppBar extends StatelessWidget {
  final String userName, coincount, streakCount;

  const HomeAppBar(
      {Key? key,
      required this.userName,
      required this.streakCount,
      required this.coincount})
      : super(key: key);

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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  color: ColorUtil(context).white,
                  size: 12.ksp,
                ),
                4.kwidthBox,
                Text(
                  date,
                  style: TextStyleUtil.genNunitoSans600(
                    color: ColorUtil(context).white,
                    fontSize: 12.kh,
                  ),
                ),
                Spacer(),
                Container(
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
                                  color: ColorUtil(context).orangeColor,
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
            12.kheightBox,
            Row(
              children: [
                // FluttermojiCircleAvatar(
                Avatar().showAvatar(
                  avatarDetails: Get.find<HomeController>()
                          .currentUser
                          .value
                          .avatardetails ??
                      '',
                  bgColor: context.blueBg,
                  context: context,
                  radius: 28.ksp,
                ),

                // ),
                // CircleAvatar(
                //   radius: 75,
                //   backgroundColor: context.blueBg,
                //   child: SvgPicture.string(
                //     FluttermojiFunctions().decodeFluttermojifromString(
                //       Get.find<HomeController>()
                //               .currentUser
                //               .value
                //               .avatardetails ??
                //           '',
                //     ),
                //     height: 75 * 1.6,
                //     semanticsLabel: "Your Fluttermoji",
                //     placeholderBuilder:
                //         (context) =>
                //             Center(child: CupertinoActivityIndicator()),
                //   ),
                // ),
                SizedBox(width: 12.ksp),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.hi.tr +
                          " " +
                          userName +
                          LocaleKeys.exclamation.tr,
                      style: TextStyleUtil.genSans600(
                        color: ColorUtil(context).white,
                        fontSize: 22.kh,
                      ),
                    ),
                    Row(
                      children: [
                        CommonImageView(svgPath: ImageConstant.flameIcon),
                        4.kwidthBox,
                        Text(
                          streakCount + " " + LocaleKeys.days_streak.tr,
                          style: TextStyleUtil.genSans400(
                            color: ColorUtil(context).white,
                            fontSize: 12.ksp,
                          ),
                        ),
                        20.kwidthBox,
                        CommonImageView(svgPath: ImageConstant.coinIcon),
                        8.kwidthBox,
                        Text(
                          coincount,
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
              onTap: () {
                Get.toNamed(Routes.HOME_SEARCH);
              },
              readOnly: true,
              enableInteractiveSelection: false,
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
