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

  Color get brandColor6 =>
      dynamicColour(light: HexColor("#DBFBCA"), dark: HexColor("#DBFBCA"));

  Color get brandBorderColor =>
      dynamicColour(light: HexColor("#A1CEB8"), dark: HexColor("#A1CEB8"));

  Color get blueBg =>
      dynamicColour(light: HexColor("#5FA9F3"), dark: HexColor("#5FA9F3"));

  Color get greenCardBg =>
      dynamicColour(light: HexColor("#238E5B"), dark: HexColor("#238E5B"));

  Color get completionScreenBg =>
      dynamicColour(light: HexColor("#EFFBF3"), dark: HexColor("#EFFBF3"));

  Color get redBg =>
      dynamicColour(light: HexColor("#EE6054"), dark: HexColor("#EE6054"));

  Color get redBg2 =>
      dynamicColour(light: HexColor("#B42318"), dark: HexColor("#B42318"));

  Color get lightRedBg =>
      dynamicColour(light: HexColor("#F39B93"), dark: HexColor("#F39B93"));

  Color get lightRedBg2 =>
      dynamicColour(light: HexColor("#FEF3F2"), dark: HexColor("#FEF3F2"));

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

  Color get darkPitch =>
      dynamicColour(light: HexColor("#FFC091"), dark: HexColor("#FFC091"));

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

  Color get darkPurple =>
      dynamicColour(light: HexColor("#3538CD"), dark: HexColor("#3538CD"));

  Color get lightPurple =>
      dynamicColour(light: HexColor("#EEF4FF"), dark: HexColor("#EEF4FF"));

  Color get lightGreenBg =>
      dynamicColour(light: HexColor("#D8F2E4"), dark: HexColor("#D8F2E4"));

  Color get greenBg =>
      dynamicColour(light: HexColor("#057A48"), dark: HexColor("#057A48"));

  Color get lightGreenBg2 =>
      dynamicColour(light: HexColor("#D8F2E4"), dark: HexColor("#D8F2E4"));

  Color get lightRed2Bg =>
      dynamicColour(light: HexColor("#EDF3F3"), dark: HexColor("#EDF3F3"));

  Color get lightRed3Bg =>
      dynamicColour(light: HexColor("#FCE4E2"), dark: HexColor("#FCE4E2"));

  Color get lightYellow2Bg =>
      dynamicColour(light: HexColor("#FEF6DF"), dark: HexColor("#FEF6DF"));

  Color get lightYellow2Border =>
      dynamicColour(light: HexColor("#FFEFC7"), dark: HexColor("#FFEFC7"));

  Color get lightOrangeBg =>
      dynamicColour(light: HexColor("#FEF5F3"), dark: HexColor("#FEF5F3"));

  Color get lightBrandColor =>
      dynamicColour(light: HexColor("#76B898"), dark: HexColor("#76B898"));

  Color get lightBrand2Color =>
      dynamicColour(light: HexColor("#CBE4D8"), dark: HexColor("#CBE4D8"));

  Color get lightBrand3Color =>
      dynamicColour(light: HexColor("#1A6541"), dark: HexColor("#1A6541"));
}
