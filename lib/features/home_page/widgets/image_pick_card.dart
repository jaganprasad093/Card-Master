import 'dart:developer';
import 'dart:io';

import 'package:card_master/core/constants/color_constants.dart';
import 'package:card_master/core/utils/image_picker_utils.dart';
import 'package:flutter/material.dart';

class ImagePickCard extends StatefulWidget {
  final Function(File) onImagePicked;
  const ImagePickCard({super.key, required this.onImagePicked});

  @override
  State<ImagePickCard> createState() => _ImagePickCardState();
}

class _ImagePickCardState extends State<ImagePickCard> {
  File? _selectedImage;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final File? pickedImage = await ImagePickerUtils.pickImage(context);
        log("picked image---$pickedImage");
        if (pickedImage != null) {
          setState(() {
            _selectedImage = pickedImage;
          });
          widget.onImagePicked(_selectedImage!);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 30,
                  width: 30,
                  child: Icon(
                    Icons.attach_file_sharp,
                    color: ColorConstants.buttonColor,
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  _selectedImage != null
                      ? _selectedImage!.path.split('/').last.length > 20
                          ? _selectedImage!.path
                                  .split('/')
                                  .last
                                  .substring(0, 26) +
                              '...'
                          : _selectedImage!.path.split('/').last
                      : "Pick Image",
                  style: TextStyle(
                    fontSize: 16,

                    color: ColorConstants.primaryBlack.withValues(alpha: .6),
                  ),
                  maxLines: 1,

                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            // Icon(Icons.add, size: 30),
          ],
        ),
      ),
    );
  }
}
