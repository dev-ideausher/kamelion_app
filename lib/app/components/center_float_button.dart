import 'package:flutter/material.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';

class CenterFloatButton extends StatelessWidget {
  CenterFloatButton({super.key, this.onTap, this.text});

  Function()? onTap;
  String? text;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.ksp,
          vertical: 8.ksp,
        ), // Reduced padding
        decoration: BoxDecoration(
          color: context.brandColor1,
          borderRadius: BorderRadius.circular(6.ksp),
          boxShadow: [
            BoxShadow(
              color: context.black.withOpacity(0.5),
              blurRadius: 6.ksp,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text ?? "", style: TextStyleUtil.genSans600(fontSize: 11.ksp)),
          ],
        ),
      ),
    );
  }
}
