import 'package:card_master/core/components/customtext.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

class ImagePickerUtils {
  static Future<File?> pickImage(BuildContext context) async {
    File? pickedImage;

    final ImageSource? source = await showCupertinoModalPopup<ImageSource>(
      context: context,
      builder:
          (context) => CupertinoActionSheet(
            title: const Text(
              'Select Image',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            message: const Text(
              'Choose a method to add your image',
              style: TextStyle(fontSize: 14),
            ),
            actions: [
              CupertinoActionSheetAction(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      data: 'Choose from Gallery',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pop(ImageSource.gallery);
                },
              ),
              CupertinoActionSheetAction(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      data: 'Take a Photo',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pop(ImageSource.camera);
                },
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              isDestructiveAction: true,
              child: CustomText(data: 'Cancel'),
              onPressed: () => Navigator.pop(context, null),
            ),
          ),
    );

    if (source != null) {
      pickedImage = await _getImage(source);
    }

    return pickedImage;
  }

  static Future<File?> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }
}
