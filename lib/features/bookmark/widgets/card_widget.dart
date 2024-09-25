import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/default_text.dart';

class CardWidget extends StatelessWidget {
  final Color bgColor;
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  const CardWidget({
    super.key,
    required this.bgColor,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(0.2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50,
                color: Colors.white,
              ),
              SizedBox(height: 20.h),
              DefaultText(
                text: text,
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
