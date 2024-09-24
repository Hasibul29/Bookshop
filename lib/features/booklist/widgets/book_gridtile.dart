import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/default_text.dart';
import '../models/booklist_model.dart';

Widget buildBookTile(Book book, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: GridTile(
      header: book.bookStatus != "0"
          ? Padding(
              padding: EdgeInsets.only(right: 40.w, top: 10.h, left: 5.w),
              child: Container(
                height: 20.h,
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: DefaultText(
                  text: "Available Now",
                  align: TextAlign.center,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.sp,
                ),
              ),
            )
          : null,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 0,
              color: Colors.black.withOpacity(0.10),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
                child: CachedNetworkImage(
                  imageUrl: book.bookCoverImage,
                  placeholder: (context, url) => Container(),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.green,
                    child: Image.asset(
                      "assets/images/book_cover.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                children: [
                  DefaultText(
                    text: book.bookName,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp,
                    maxLines: 2,
                    textOverflow: TextOverflow.ellipsis,
                    align: TextAlign.center,
                  ),
                  SizedBox(height: 5.h),
                  DefaultText(
                    text: book.bookWriter,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis,
                    align: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    ),
  );
}
