import 'package:card_master/core/components/custom_textformfield.dart';
import 'package:card_master/core/constants/color_constants.dart';
import 'package:card_master/core/constants/size_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BuildTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? icon;
  final String? iconAsset;
  final TextInputType? keyboardType;
  final int? maxLength;
  final int maxLines;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;

  const BuildTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.icon,
    this.inputFormatters,
    this.iconAsset,
    this.keyboardType,
    this.maxLength,
    this.maxLines = 1,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: SizeConstants.height(context) * 0.02),
      child: CustomTextField(
        inputFormatters: inputFormatters,
        controller: controller,
        hintText: hintText,
        // obscureText: obscureText,
        prefix: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConstants.width(context) * 0.03,
          ),
          child:
              iconAsset != null
                  ? SizedBox(height: 25, child: Image.asset(iconAsset!))
                  : Icon(icon, size: 25, color: ColorConstants.buttonColor),
        ),
        keyboardType: keyboardType,
        maxLength: maxLength,
        maxLines: maxLines,
        contentPadding: EdgeInsets.symmetric(
          vertical: SizeConstants.height(context) * 0.018,
          horizontal: SizeConstants.width(context) * 0.03,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $hintText';
          }
          return null;
        },
      ),
    );
  }
}
