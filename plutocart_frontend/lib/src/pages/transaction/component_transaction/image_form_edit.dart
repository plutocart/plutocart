import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageFromEdit extends StatelessWidget {
  final String? image;
  final Function()? onViewImage;
  final Function()? onDeleteImage;

  const ImageFromEdit({
    Key? key,
    required this.image,
    required this.onViewImage,
    required this.onDeleteImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 1,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF15616D)),
        borderRadius: BorderRadius.circular(16),
      ),
      child:Padding(
              padding: const EdgeInsets.all(5.0),
              child: GestureDetector(
                onTap: onViewImage,
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 1,
                      decoration:  BoxDecoration(
                        image: DecorationImage(
                           image: NetworkImage(image!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: onDeleteImage, // ระบุ event ตามที่ต้องการ
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: MediaQuery.of(context).size.height * 0.04,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/icon/delete_image_icon.png'),
                              fit: BoxFit.contain, // หรือเลือก fit ตามที่ต้องการ
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
