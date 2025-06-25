import 'package:flutter/material.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'responsive_size.dart';
import 'colors.dart';
import 'text_style_util.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final bool disabled;
  final bool isloading;
  final void Function()? onTap;
  final bool outline;
  final Widget? leading;
  final Widget? trailing;
  final LinearGradient? linearGradient;
  final Color? color;
  final Color? buttonColor;
  final double? borderRadius;
  final double? height;

  const CustomButton({
    Key? key,
    required this.title,
    this.disabled = false,
    this.isloading = false,
    this.onTap,
    this.leading,
    this.trailing,
    this.linearGradient,
    this.color,
    this.borderRadius,
    this.height,
    this.buttonColor,
  }) : outline = false,
       super(key: key);

  const CustomButton.outline({
    required this.title,
    this.disabled = false,
    this.onTap,
    this.leading,
    this.trailing,
    this.linearGradient,
    this.color,
    this.buttonColor,
    this.borderRadius,
    this.isloading = false,
    this.height,
  }) : outline = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            height: height ?? 48.kh,
            alignment: Alignment.center,
            decoration:
                !outline
                    ? BoxDecoration(
                      // color: !disabled ? color ?? ColorUtil.kcPrimaryColor : color ?? ColorUtil.kcMediumGreyColor,
                      borderRadius: BorderRadius.circular(
                        borderRadius ?? 12.kh,
                      ),
                      // gradient: linearGradient ??
                      //     LinearGradient(begin: Alignment(0, 0), end: Alignment(0, 0), colors: [
                      //       !disabled ? color ?? ColorUtil. : color ?? ColorUtil.kcMediumGreyColor,
                      //       !disabled ? color ?? ColorUtil.kcPrimaryColor : color ?? ColorUtil.kcMediumGreyColor
                      //     ]),
                    )
                    : BoxDecoration(
                      color:
                          !disabled
                              ? buttonColor ?? context.brandColor1
                              : context.disabledButtonColor,
                      borderRadius: BorderRadius.circular(
                        borderRadius ?? 12.kh,
                      ),
                      border: Border.all(
                        color:
                            !disabled
                                ? color ?? context.brandColor1
                                : context.disabledButtonColor,
                        width: 1,
                      ),
                    ),
            child:
                !isloading
                    ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (leading != null) leading!,
                        if (leading != null) SizedBox(width: 10.kw),
                        Text(
                          title,
                          style: TextStyleUtil.genSans400(
                            // fontWeight: !outline ? FontWeight.bold : FontWeight.w400,
                            fontSize: 13.ksp,
                            color:
                                !disabled
                                    ? (!outline
                                        ? Colors.white
                                        : ColorUtil(context).white)
                                    : (!outline
                                        ? Colors.white
                                        : ColorUtil(context).disabledTextColor),
                          ),
                        ),
                        if (trailing != null) SizedBox(width: 5.kw),
                        if (trailing != null) trailing!,
                      ],
                    )
                    : CircularProgressIndicator(
                      strokeWidth: 8,
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
          ),
        ),
        // Material(
        //   color: Colors.transparent,
        //   child: InkWell(
        //     onTap: () {},
        //     child: Ink(width: double.infinity, height: 48.kh),
        //   ),
        // ),
      ],
    );
  }
}
