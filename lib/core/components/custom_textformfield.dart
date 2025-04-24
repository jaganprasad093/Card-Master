import 'package:card_master/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefix;
  final String? prefixText;
  final String? errorText;
  final TextInputType? keyboardType;
  final int? maxLength;
  final int? minLines;
  final bool? readOnly;
  final bool? enabled;
  final bool? isBorder;
  final int? maxLines;
  final Color? color;
  final FocusNode? focusNode;
  final Color? fillColor;
  final Function(String)? onChanged;
  final String? suffixText;
  final List<TextInputFormatter>? inputFormatters;

  CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.validator,
    this.onTap,
    this.suffixIcon,
    this.contentPadding,
    this.prefix,
    this.prefixText,
    this.errorText,
    this.keyboardType,
    this.maxLength,
    this.minLines,
    this.onChanged,
    this.readOnly,
    this.enabled,
    this.maxLines,
    this.suffixText,
    this.inputFormatters,
    this.color,
    this.focusNode,
    this.fillColor,
    this.isBorder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool obscureText = isPassword;

    return StatefulBuilder(
      builder: (context, setState) {
        return TextFormField(
          focusNode: focusNode,
          onChanged: onChanged,
          inputFormatters: inputFormatters,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          maxLines: isPassword ? 1 : maxLines,
          enabled: enabled,
          readOnly: readOnly ?? false,
          onTap: onTap,
          controller: controller,
          obscureText: obscureText,
          maxLength: maxLength,

          minLines: minLines,
          keyboardType: keyboardType,

          decoration: InputDecoration(
            filled: true,
            fillColor:
                fillColor == null ? ColorConstants.primaryWhite : fillColor,
            suffixText: suffixText,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color:
                    isBorder == null
                        ? Colors.transparent
                        : ColorConstants.primaryBlack.withValues(alpha: .5),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color:
                    isBorder == null
                        ? Colors.transparent
                        : ColorConstants.primaryBlack.withValues(alpha: .5),
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: color ?? Colors.transparent),
            ),

            prefixIcon: prefix,
            counterText: "",
            errorText: errorText,
            contentPadding:
                contentPadding == null
                    ? EdgeInsets.symmetric(vertical: 10, horizontal: 10)
                    : contentPadding,
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 15,
              color: ColorConstants.primaryBlack.withValues(alpha: .6),
            ),
            prefixText: prefixText,
            // isDense: true,
            prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
            suffixIcon:
                isPassword
                    ? GestureDetector(
                      onTap: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      child: Icon(
                        color: ColorConstants.primaryBlack.withValues(
                          alpha: .5,
                        ),
                        obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                    )
                    : suffixIcon,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          validator: validator,
        );
      },
    );
  }
}
