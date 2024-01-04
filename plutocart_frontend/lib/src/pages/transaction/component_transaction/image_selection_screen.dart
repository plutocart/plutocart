import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class ImageSelectionScreen extends StatelessWidget {
  final XFile? image;
  final Function()? getImageFromCamera;
  final Function()? getImageFromGallery;
  final Function()? onViewImage;
  final Function()? onDeleteImage;

  const ImageSelectionScreen({
    Key? key,
    required this.image,
    required this.getImageFromCamera,
    required this.getImageFromGallery,
    required this.onViewImage,
    required this.onDeleteImage,
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 1,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF15616D)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: image == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Color(0xFF15616D)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                width: 1,
                                color: Color(0xFF15616D),
                              ),
                            ),
                          ),
                        ),
                        onPressed: getImageFromCamera,
                        child: Row(
                          children: [
                            Icon(Icons.camera_alt_rounded),
                            Text("Camera"),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Color(0xFF15616D)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                width: 1,
                                color: Color(0xFF15616D),
                              ),
                            ),
                          ),
                        ),
                        onPressed: getImageFromGallery,
                        child: Row(
                          children: [
                            Icon(Icons.image),
                            Text("Gallery"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: onViewImage,
                  child: Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 1,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(File(image!.path)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Color(0XFF15616D),
                          ),
                          onPressed: onDeleteImage,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
