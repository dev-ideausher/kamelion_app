import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyleUtil {
  static TextStyle genSans300({
    Color color = Colors.white,
    required double fontSize,
  }) {
    return GoogleFonts.quicksand(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w300,
    );
    //  TextStyle(
    //   fontFamily: ,

    // );
  }

  static TextStyle genSans400({
    Color color = Colors.white,
    required double fontSize,
    double? height,
  }) {
    return GoogleFonts.quicksand(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      height: height,
    );

    // TextStyle(fontFamily: GoogleFonts.getFont('Quicksand'));
  }


  static TextStyle genNunitoSans400({
    Color color = Colors.white,
    required double fontSize,
    double? height,
  }) {
    return GoogleFonts.nunitoSans(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      height: height,
    );

    // TextStyle(fontFamily: GoogleFonts.getFont('Quicksand'));
  }


  static TextStyle genNunitoSans600({
    Color color = Colors.white,
    required double fontSize,
    double? height,
  }) {
    return GoogleFonts.nunitoSans(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      height: height,
    );

    // TextStyle(fontFamily: GoogleFonts.getFont('Quicksand'));
  }



  static TextStyle genNunitoSans500({
    Color color = Colors.white,
    required double fontSize,
    double? height,
  }) {
    return GoogleFonts.nunitoSans(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      height: height,
    );

    // TextStyle(fontFamily: GoogleFonts.getFont('Quicksand'));
  }


  static TextStyle genNunitoSans700({
    Color color = Colors.white,
    required double fontSize,
    double? height,
  }) {
    return GoogleFonts.nunitoSans(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      height: height,
    );

  }

  static TextStyle genSans500({
    Color color = Colors.white,
    required double fontSize,
    double? height,
  }) {
    return GoogleFonts.quicksand(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
    );
  }



  static TextStyle genSans700({
    Color color = Colors.white,
    required double fontSize,
    double? height,
  }) {
    return GoogleFonts.quicksand(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
    );
  }



  static TextStyle genSans800({
    Color color = Colors.white,
    required double fontSize,
    double? height,
  }) {
    return GoogleFonts.quicksand(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w800,
    );
  }


  static TextStyle genSans900({
    Color color = Colors.white,
    required double fontSize,
    double? height,
  }) {
    return GoogleFonts.quicksand(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w900,
    );
  }

  static TextStyle genSans600({
    Color color = Colors.white,
    required double fontSize,
  }) {
    return GoogleFonts.quicksand(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
    );
  }
  // static TextStyle genSans700({
  //   Color color = Colors.white,
  //   double? height,
  //   required double fontSize,
  // }) {
  //   return TextStyle(
  //     height: height,
  //     color: color,
  //     fontSize: fontSize,
  //     fontWeight: FontWeight.w600,
  //   );
  // }
}




extension AppText on String {
  String get string => this;

  Widget text300(
    double fontSize, {
    Color color = Colors.black,
    TextAlign? textAlign,
  }) => Text(
    string,
    textAlign: textAlign,
    style: TextStyle(
      fontFamily: 'General Sans',
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w300,
    ),
  );

  Widget text400(
    double fontSize, {
    Color color = Colors.black,
    TextAlign? textAlign,
  }) => Text(
    string,
    textAlign: textAlign,
    style: TextStyle(
      fontFamily: 'General Sans',
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
    ),
  );

  Widget text500(
    double fontSize, {
    Color color = Colors.black,
    TextAlign? textAlign,
  }) => Text(
    string,
    textAlign: textAlign,
    style: TextStyle(
      fontFamily: 'General Sans',
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
    ),
  );

  Widget text600(
    double fontSize, {
    Color color = Colors.black,
    TextAlign? textAlign,
    TextStyle? style,
  }) => Text(
    string,
    textAlign: textAlign,
    style:
        style ??
        TextStyle(
          fontFamily: 'General Sans',
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
  );
}
