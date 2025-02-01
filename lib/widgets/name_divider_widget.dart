import 'package:flutter/material.dart';
import 'package:messcoin/res/app_colors.dart';

class NameDividerWidget extends StatelessWidget {
  const NameDividerWidget({super.key, required this.name});

  final String name;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$name  ",
          style: TextStyle(
              color: AppColors.nightSky,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600),
        ),
        Expanded(child: Divider())
      ],
    );
  }
}
