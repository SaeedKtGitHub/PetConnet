import 'package:flutter/material.dart';

import '../../../core/constant/color.dart';

class CustomTextSignUpOrSignIn extends StatelessWidget {
  const CustomTextSignUpOrSignIn(
      {super.key,
      required this.textOne,
      required this.textTwo,
      required this.onTap});
  final String textOne;
  final String textTwo;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          textOne,
          style: const TextStyle(fontSize: 18),
        ),
        InkWell(
          onTap: onTap,
          child: Text(textTwo,
              style: const TextStyle(
                color: AppColor.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
        )
      ],
    );
  }
}
