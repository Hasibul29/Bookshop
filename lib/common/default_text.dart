import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultText extends StatelessWidget {
  const DefaultText({
    super.key,
    required this.text,
    required this.fontWeight,
    required this.fontSize,
    this.fontFamily = "NotoSans",
    this.color = Colors.black,
    this.maxLines,
    this.align = TextAlign.left,
    this.textOverflow = TextOverflow.ellipsis,
    this.decoration = TextDecoration.none,
    this.withSp = true,
    this.height = 20,
    this.letterSpacing,
    this.decorationColor = Colors.black,
  });

  final String text;
  final Color color;
  final int? maxLines;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign align;
  final String fontFamily;
  final TextOverflow textOverflow;
  final TextDecoration decoration;
  final bool withSp;
  final double height;
  final double? letterSpacing;
  final Color decorationColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        fontSize: withSp ? fontSize.sp : fontSize,
        fontFamily: fontFamily,
        height: withSp ? height / fontSize.sp : height / fontSize,
        letterSpacing: letterSpacing,
        overflow: textOverflow,
        fontWeight: fontWeight,
        decoration: decoration,
        decorationColor: decorationColor,
      ),
    );
  }
}
