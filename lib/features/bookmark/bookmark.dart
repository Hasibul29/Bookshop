import 'package:bookshop/features/bookmark/level_bookmark.dart';
import 'package:bookshop/features/bookmark/word_bookmark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/default_text.dart';
import 'widgets/card_widget.dart';

class Bookmark extends StatelessWidget {
  const Bookmark({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 14.h),
          const DefaultText(
            text: "Bookmark",
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
          SizedBox(height: 40.h),
          SizedBox(
            height: 200.h,
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: CardWidget(
                    bgColor: Colors.red,
                    icon: Icons.book,
                    text: "Book",
                    onTap: () {},
                  ),
                ),
                SizedBox(width: 10.h),
                Expanded(
                  child: CardWidget(
                    bgColor: Colors.green,
                    icon: Icons.gamepad_outlined,
                    text: "Level",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LevelBookmark(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          CardWidget(
            bgColor: Colors.blue,
            icon: Icons.translate,
            text: "Words",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WordBookmark(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
