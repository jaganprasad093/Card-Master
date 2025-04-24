import 'package:card_master/core/constants/color_constants.dart';
import 'package:card_master/core/constants/size_constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? text;

  final Gradient? gradient;
  final double? fontSize;
  final Function()? onTap;
  final Widget? child;
  final EdgeInsetsGeometry? padding;

  const CustomButton({
    Key? key,
    this.text,

    this.gradient,
    this.fontSize,
    this.onTap,
    this.padding,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        constraints: BoxConstraints(
          minWidth: SizeConstants.width(context) * 0.5,
          minHeight: SizeConstants.height(context) * 0.045,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff03A8A1), Color(0xff2CB892), Color(0xff4ECB84)],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child:
              child ??
              Text(
                text ?? "",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: fontSize ?? 13,
                ),
              ),
        ),
      ),
    );
  }
}
