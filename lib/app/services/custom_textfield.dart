import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';


class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final Function(String)? onChange;
  final Widget? prefixIcon;
  final Widget? prefixIconWidget;
  final Widget? suffixIconWidget;
  final Color? fillColor;
  final bool? filled;
  final int? maxLines;
  final bool? readOnly;
  final List<TextInputFormatter> inputFormatters;
  final String? Function(String?)? validator;
  final Function(String)? onFieldSubmitted;
  FocusNode? focusNode;

  CustomTextField({
    Key? key,
    required this.hintText,
    this.controller,
    this.onChange,
    this.prefixIcon,
    this.fillColor,
    this.filled,
    this.maxLines,
    this.prefixIconWidget,
    this.suffixIconWidget,
    this.readOnly,
    this.inputFormatters = const [],
    this.validator,
    this.onFieldSubmitted,
    this.focusNode
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(validator: validator,
      focusNode: focusNode,
      onFieldSubmitted:onFieldSubmitted,
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
        suffixIcon:suffixIconWidget ,
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
class CustomTextFieldPassword extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final Function(String)? onChange;
  final Widget? prefixIcon;
  final Widget? prefixIconWidget;
  final Widget? suffixIconWidget;
  final Color? fillColor;
  final bool? filled;
  final int? maxLines;
  final bool? readOnly;
  final List<TextInputFormatter> inputFormatters;
  final String? Function(String?)? validator;
  final Function(String)? onFieldSubmitted;
  final bool isPassword;

  const CustomTextFieldPassword({
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
    this.validator,
    this.onFieldSubmitted,
    this.isPassword = false,
    this.suffixIconWidget, // Default is not a password field
  }) : super(key: key);

  @override
  State<CustomTextFieldPassword> createState() =>
      _CustomTextFieldPasswordState();
}

class _CustomTextFieldPasswordState extends State<CustomTextFieldPassword> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(

        decoration: BoxDecoration(
          color: context.white,
          borderRadius: BorderRadius.all(Radius.circular(8.ksp)),
          boxShadow: [
            BoxShadow(
              color: context.grey.withOpacity(0.2),
              blurRadius: 5,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: TextFormField(

            obscureText: widget.isPassword ? _obscureText : false,
            validator: widget.validator,
            onFieldSubmitted: widget.onFieldSubmitted,
            inputFormatters: widget.inputFormatters,
            readOnly: widget.readOnly ?? false,
            onChanged: widget.onChange,
            controller: widget.controller,
            decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyleUtil.genNunitoSans400(
                  fontSize: 12.ksp,
                  color: context.greyDark,
                ),
                fillColor: context.white,
                filled: widget.filled,
                prefix: widget.prefixIcon,
                prefixIcon: widget.prefixIconWidget,

                suffixIcon:

                // SvgPicture.asset(
                //     height: 30.kh,
                //     "assets/svg/eye.svg",
                //   color: Colors.black,
                //
                // ),
                widget.isPassword
                    ? SizedBox(
                  height: 12,
                  width: 12,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: _obscureText
                          ?
                      SizedBox(
                        height: 14.ksp,
                        width: 14.ksp,
                        child: SvgPicture.asset(
                          "assets/svg/eye.svg",
                        ),
                      ) : SizedBox(
                        height: 14.ksp,
                        width: 14.ksp,
                        child: SvgPicture.asset("assets/svg/eye_hide.svg",

                        ),
                      ),
                    ),
                  ),
                )
                    : widget.suffixIconWidget,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 14.kw, vertical: 10.kh),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.ksp),
                  borderSide:
                  BorderSide(color: ColorUtil(context).grey.withOpacity(0.7)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.ksp),
                  borderSide: BorderSide(
                      color: ColorUtil(context).grey.withOpacity(0.7),
                      width: 1.ksp),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.ksp),
                  borderSide: BorderSide(color: ColorUtil(context).brandColor1),
                ))));
  }
}