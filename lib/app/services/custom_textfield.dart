import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final Function(String)? onChange;
  final Widget? prefixIcon;
  final Widget? prefixIconWidget;
  final Color? fillColor;
  final bool? filled;
  final int? maxLines;
  final bool? readOnly;
  final List<TextInputFormatter> inputFormatters;

  const CustomTextField({
    Key? key,
    required this.hintText,
    this.controller,
    this.onChange,
    this.prefixIcon,
    this.fillColor,
    this.filled,
    this.maxLines,
    this.prefixIconWidget,
    this.readOnly,
    this.inputFormatters = const [],
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      readOnly: readOnly ?? false,
      onChanged: onChange,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyleUtil.genSans400(
          fontSize: 12.ksp,
          color: context.greyDark,
        ),
        fillColor: fillColor,
        filled: filled,
        prefix: prefixIcon,
        prefixIcon: prefixIconWidget,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.ksp),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.ksp), // Rounded corners
          borderSide: BorderSide(color: ColorUtil(context).grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.ksp),
          borderSide: BorderSide(color: ColorUtil(context).grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.ksp),
          borderSide: BorderSide(color: ColorUtil(context).brandColor1),
        ),
      ),
    );
  }
}
