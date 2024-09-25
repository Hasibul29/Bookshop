import 'package:bookshop/common/default_text.dart';
import 'package:bookshop/features/booklist/models/booklist_model.dart';
import 'package:bookshop/features/bookmark/database/bookmark_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/default_appbar.dart';
import '../bookmark/provider/bookmark_provider.dart';

class BookDetails extends ConsumerWidget {
  final Book book;
  const BookDetails({super.key, required this.book});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBookmarked = ref.watch(getBookmarkedBookByIdProvider(book.id));
    return Scaffold(
      appBar: DefaultAppBar(
        title: book.bookName,
        hasActionButton: true,
        icon: isBookmarked.maybeWhen(
          data: (bookmarked) => bookmarked != null
              ? const Icon(Icons.star, color: Colors.green)
              : const Icon(Icons.star_border_outlined),
          orElse: () => const Icon(Icons.star_border_outlined),
        ),
        onPressed: () async {
          bool isBookmarkedValue = isBookmarked.maybeWhen(
            data: (bookmarked) => bookmarked != null,
            orElse: () => false,
          );
          await ref.read(bookmarkNotifierProvider.notifier).toggleBookBookmark(
              BookBookmarkEntity.fromBook(book), isBookmarkedValue);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Center(
              child: CachedNetworkImage(
                imageUrl: book.bookCoverImage,
                placeholder: (context, url) => Container(),
                errorWidget: (context, url, error) => Container(
                  color: Colors.green,
                  child: Image.asset(
                    "assets/images/book_cover.png",
                    fit: BoxFit.fitWidth,
                  ),
                ),
                fit: BoxFit.fitWidth,
                width: double.infinity,
              ),
            ),
            SizedBox(height: 20.h),
            DefaultText(
              text: book.bookName,
              fontWeight: FontWeight.w600,
              fontSize: 22,
              align: TextAlign.center,
            ),
            SizedBox(height: 10.h),
            DefaultText(
              text: 'Written by : ${book.bookWriter}',
              fontWeight: FontWeight.w500,
              fontSize: 18,
              align: TextAlign.center,
            ),
            SizedBox(height: 10.h),
            DefaultText(
              text: 'Published by : ${book.bookPublisher}',
              fontWeight: FontWeight.w500,
              fontSize: 18,
              align: TextAlign.center,
            ),
            SizedBox(height: 30.h),
            book.bookStatus == "1"
                ? Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10)),
                    child: DefaultText(
                      text: book.bookAvailable,
                      fontWeight: FontWeight.w500,
                      maxLines: 3,
                      fontSize: 16,
                      align: TextAlign.center,
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.yellow.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10)),
                    child: DefaultText(
                      text: "Available from ${book.bookNotAvailable}",
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      align: TextAlign.center,
                    ),
                  ),
            SizedBox(height: 10.h),
            DefaultText(
              text: 'Type : ${book.bookType}',
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            SizedBox(height: 10.h),
            DefaultText(
              text: 'Category : ${book.bookCategory}',
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            SizedBox(height: 10.h),
            DefaultText(
              text: "Total times read : ${book.totalRead}",
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                DefaultText(
                  text: 'Average Review : ${book.bookAverageReview} ',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                const Icon(
                  Icons.star_rounded,
                  color: Colors.green,
                )
              ],
            ),
            SizedBox(height: 20.h),
            const DefaultText(
              text: 'Book Reviews',
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
            SizedBox(height: 10.h),
            DefaultText(
              text: book.bookReview,
              maxLines: 10000,
              fontWeight: FontWeight.w400,
              fontSize: 16,
              align: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
