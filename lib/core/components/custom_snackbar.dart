import 'dart:developer';
import 'package:flutter/material.dart';

void customSnackBar({
  required String message,
  required BuildContext context,
  Duration? duration,
  EdgeInsetsGeometry? padding,
  Color? textColor,
  Color? backgroundColor,
  bool showOnTop = false,
}) {
  if (!context.mounted) {
    debugPrint('Invalid context or widget is not mounted');
    return;
  }

  log("showOnTop: $showOnTop");

  try {
    final screenSize = MediaQuery.of(context).size;
    final horizontalPadding = screenSize.width * 0.05;

    final margin = showOnTop
        ? EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 10,
            left: horizontalPadding,
            right: horizontalPadding,
          )
        : EdgeInsets.only(
            bottom: 100,
            left: horizontalPadding,
            right: horizontalPadding,
          );

    var snack = SnackBar(
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: 16,
          ),
      backgroundColor: backgroundColor ?? Colors.red[300] ?? Colors.red,
      behavior: SnackBarBehavior.floating,
      margin: margin,
      duration: duration ?? const Duration(milliseconds: 3000),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 6,
      content: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: textColor ?? Colors.white,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: textColor ?? Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snack);
  } catch (e) {
    debugPrint('Error showing snackbar: $e');
  }
}
