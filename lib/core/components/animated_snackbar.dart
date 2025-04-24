// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// import 'package:flutter/material.dart';

// class AnimatedSnackBar {
//   static OverlayEntry? _currentOverlay;

//   static void show({
//     required BuildContext context,
//     required String title,
//     required String message,
//     ContentType? contentType,
//     Duration duration = const Duration(seconds: 3),
//   }) {
//     // Hide any existing snackbar
//     _currentOverlay?.remove();

//     final screenSize = MediaQuery.of(context).size;
//     final snackBarWidth =
//         screenSize.width > 600 ? 500.0 : screenSize.width - 32;

//     final snackBar = AwesomeSnackbarContent(
//       title: title,
//       message: message,
//       contentType: contentType ?? ContentType.success,
//       color: _getSnackBarColor(contentType ?? ContentType.success),
//     );

//     _currentOverlay = OverlayEntry(
//       builder: (context) => Positioned(
//         bottom: MediaQuery.of(context).viewInsets.bottom + 60,
//         left: screenSize.width > 600
//             ? (screenSize.width - snackBarWidth) / 2
//             : 16,
//         right: screenSize.width > 600
//             ? (screenSize.width - snackBarWidth) / 2
//             : 16,
//         child: Material(
//           color: Colors.transparent,
//           child: SizedBox(
//             width: snackBarWidth,
//             child: snackBar,
//           ),
//         ),
//       ),
//     );

//     Overlay.of(context).insert(_currentOverlay!);
//     Future.delayed(duration, () {
//       _currentOverlay?.remove();
//       _currentOverlay = null;
//     });
//   }

//   static Color _getSnackBarColor(ContentType type) {
//     if (type == ContentType.success)
//       return const Color.fromARGB(255, 70, 163, 75);
//     if (type == ContentType.failure)
//       return const Color.fromARGB(255, 225, 72, 72);
//     if (type == ContentType.warning) return const Color(0xFFF57F17);
//     if (type == ContentType.help) return const Color(0xFF1565C0);
//     return Colors.grey;
//   }
// }
