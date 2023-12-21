import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomProfileImage extends StatelessWidget {
  final File? imageFile;
  final VoidCallback? onPressed;


  const CustomProfileImage({super.key, 
    required this.imageFile,
    this.onPressed,

  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // The profile image container
        SizedBox(
          width: 170.0.w, // Adjust as needed
          height: 170.0.h, // Adjust as needed

          child: CircleAvatar(
            radius: 80.0.h, // Adjust as needed
            backgroundColor: Colors.transparent,
            backgroundImage: FileImage(imageFile!),
          ),
        ),

        // The camera container

      ],
    );
  }
}
