import 'dart:io';

import 'package:card_master/core/constants/image_constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class CardServices {
  // formatting the card number
  static String formatCardNumber(String input) {
    if (input.isEmpty) return "XXXX XXXX XXXX XXXX";
    String formatted = "";
    for (int i = 0; i < input.length; i++) {
      if (i > 0 && i % 4 == 0) formatted += " ";
      formatted += input[i];
    }

    while (formatted.length < 19) {
      if (formatted.isNotEmpty && formatted.length % 5 == 4) {
        formatted += " ";
      }
      formatted += "X";
    }
    return formatted;
  }

  static String formatExpiryDate(String input) {
    if (input.length >= 2) {
      return '${input.substring(0, 2)}/${input.length > 2 ? input.substring(2) : ''}';
    }
    return input;
  }

  static Future<XFile?> pickBankLogo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    return pickedFile;
  }

  static String changeBackground(String currentBackground) {
    if (currentBackground == ImageConstants.card1) {
      return ImageConstants.card2;
    } else if (currentBackground == ImageConstants.card2) {
      return ImageConstants.card3;
    } else if (currentBackground == ImageConstants.card3) {
      return ImageConstants.card4;
    } else {
      return ImageConstants.card1;
    }
  }

  // Upload image to Firebase Storage
  static Future<String> uploadImageToFirebase(File imageFile) async {
    try {
      String fileName =
          'card_images/${DateTime.now().millisecondsSinceEpoch}.jpg';

      // Upload to Firebase Storage
      Reference storageRef = FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = storageRef.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;

      // Get the download URL
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(' '); // Add a space after every 4 digits
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}

class ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex == 2 && nonZeroIndex != text.length) {
        buffer.write('/'); // Add a slash after 2 digits
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}
