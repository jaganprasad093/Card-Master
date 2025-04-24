import 'package:card_master/core/constants/color_constants.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String hintText;
  final Widget? prefix;
  final String? value;

  final List<String> items;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;

  const CustomDropdown({
    Key? key,
    required this.hintText,
    this.value,
    required this.items,
    this.validator,
    this.onChanged,
    this.prefix,
    this.contentPadding,
    this.fillColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: TextStyle(
        color: ColorConstants.primaryBlack.withValues(alpha: .8),
        fontSize: 16,
      ),
      value: value,
      onChanged: onChanged,
      validator: validator,

      decoration: InputDecoration(
        prefix: prefix,
        filled: true,
        fillColor: fillColor ?? ColorConstants.primaryWhite,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        hintText: hintText,
        hintStyle: TextStyle(
          color: ColorConstants.primaryBlack.withValues(alpha: .5),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      items:
          items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
    );
  }
}
