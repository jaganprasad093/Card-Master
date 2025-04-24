import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatefulWidget {
  final String data;
  final TextStyle? style;
  final int? maxLines;
  final int? maxLength;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final bool showEllipsis;
  const CustomText({
    super.key,
    required this.data,
    this.style,
    this.textAlign,
    this.maxLines,
    this.maxLength,
    this.overflow,
    this.showEllipsis = true,
  });

  @override
  State<CustomText> createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  String _getProcessedText() {
    if (widget.maxLength == null || widget.data.length <= widget.maxLength!) {
      return widget.data;
    }
    return widget.showEllipsis
        ? '${widget.data.substring(0, widget.maxLength)}...'
        : widget.data.substring(0, widget.maxLength);
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _getProcessedText(),
      maxLines: widget.maxLines,
      overflow:
          widget.overflow ??
          (widget.maxLength != null ? TextOverflow.ellipsis : null),
      textAlign: widget.textAlign,
      style: GoogleFonts.raleway(textStyle: widget.style),
    );
  }
}
