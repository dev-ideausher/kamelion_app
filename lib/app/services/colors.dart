import 'package:flutter/material.dart';
import 'hexColorToFlutterColor.dart';

extension ColorUtil on BuildContext {
  Color dynamicColor({required int light, required int dark}) {
    return (Theme.of(this).brightness == Brightness.light)
        ? Color(light)
        : Color(dark);
  }

  Color dynamicColour({required Color light, required Color dark}) {
    return (Theme.of(this).brightness == Brightness.light) ? light : dark;
  }

  Color get brandColor1 =>
      dynamicColour(light: HexColor("#238E5B"), dark: HexColor("#238E5B"));

  Color get brandColor1Light =>
      dynamicColour(light: HexColor("#E8FAF0"), dark: HexColor("#E8FAF0"));

  Color get brandColor2 =>
      dynamicColour(light: HexColor("#8032A8"), dark: HexColor("#000000"));

  Color get brandColor3 =>
      dynamicColour(light: HexColor("#FF6D00"), dark: HexColor("#FF6D00"));

  Color get brandColor4 =>
      dynamicColour(light: HexColor("#FFA35E"), dark: HexColor("#FFA35E"));

  Color get brandColor5 =>
      dynamicColour(light: HexColor("#E9F4EF"), dark: HexColor("#E9F4EF"));

  Color get brandBorderColor =>
      dynamicColour(light: HexColor("#A1CEB8"), dark: HexColor("#A1CEB8"));

  Color get blueBg =>
      dynamicColour(light: HexColor("#5FA9F3"), dark: HexColor("#5FA9F3"));

  Color get greenCardBg =>
      dynamicColour(light: HexColor("#238E5B"), dark: HexColor("#238E5B"));

  Color get redBg =>
      dynamicColour(light: HexColor("#EE6054"), dark: HexColor("#EE6054"));

  Color get lightRedBg =>
      dynamicColour(light: HexColor("#F39B93"), dark: HexColor("#F39B93"));

  Color get goodMoodBg =>
      dynamicColour(light: HexColor("#FFF0E6"), dark: HexColor("#FFF0E6"));

  Color get lightPinkBg =>
      dynamicColour(light: HexColor("#FFF5F3"), dark: HexColor("#FFF5F3"));

  Color get normalMoodBg =>
      dynamicColour(light: HexColor("#FFFBF2"), dark: HexColor("#FFFBF2"));

  Color get pitcgBg =>
      dynamicColour(light: HexColor("#FF9B85"), dark: HexColor("#FF9B85"));

  Color get shadowColor =>
      dynamicColour(light: HexColor("#B64D00"), dark: HexColor("#B64D00"));

  Color get disabledButtonColor =>
      dynamicColour(light: HexColor("#E9F4EF"), dark: HexColor("#E9F4EF"));

  Color get disabledTextColor =>
      dynamicColour(light: HexColor("#A1CEB8"), dark: HexColor("#A1CEB8"));

  Color get black =>
      dynamicColour(light: HexColor("#000000"), dark: HexColor("#000000"));

  Color get white =>
      dynamicColour(light: HexColor("#FFFFFF"), dark: HexColor("#FFFFFF"));

  Color get grey =>
      dynamicColour(light: HexColor("#D5D7DA"), dark: HexColor("#D5D7DA"));

  Color get greyBg2 =>
      dynamicColour(light: HexColor("#F2F2F2"), dark: HexColor("#F2F2F2"));

  Color get greyDark =>
      dynamicColour(light: HexColor("#717680"), dark: HexColor("#717680"));

  Color get greyBg =>
      dynamicColour(light: HexColor("#EEEEEF"), dark: HexColor("#EEEEEF"));

  Color get lightBlack =>
      dynamicColour(light: HexColor("#3F4550"), dark: HexColor("#3F4550"));

  Color get scaffoldBg =>
      dynamicColour(light: HexColor("#FCFCFC"), dark: HexColor("#FCFCFC"));

  Color get darkRedText =>
      dynamicColour(light: HexColor("#C4320A"), dark: HexColor("#C4320A"));

  Color get lighPitchBg =>
      dynamicColour(light: HexColor("#FEF6ED"), dark: HexColor("#FEF6ED"));

  Color get lighPinkBorder =>
      dynamicColour(light: HexColor("#F8BBB5"), dark: HexColor("#F8BBB5"));

  Color get lighPinkBg =>
      dynamicColour(light: HexColor("#FCD9D6"), dark: HexColor("#FCD9D6"));

  Color get lightYellowBg =>
      dynamicColour(light: HexColor("#FEF6E0"), dark: HexColor("#FEF6E0"));

  Color get lightYellowBorder =>
      dynamicColour(light: HexColor("#D8B96A"), dark: HexColor("#D8B96A"));
}
