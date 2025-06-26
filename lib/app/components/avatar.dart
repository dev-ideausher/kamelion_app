import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttermoji/fluttermojiFunctions.dart';

class Avatar {
  showAvatar({
    dynamic context,
    required String avatarDetails,
    required double radius,
    required Color bgColor,
  }) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: bgColor,
      child: SvgPicture.string(
        FluttermojiFunctions().decodeFluttermojifromString(avatarDetails),
        height: radius * 1.6,
        semanticsLabel: "Your Fluttermoji",
        placeholderBuilder:
            (context) => Center(child: CupertinoActivityIndicator()),
      ),
    );
  }
}
