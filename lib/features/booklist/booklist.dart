import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/default_text.dart';
import 'models/booklist_model.dart';
import 'provider/booklist_provider.dart';
import 'widgets/shimmer_skeleton.gridtile.dart';

class BookListView extends ConsumerWidget {
  const BookListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookListState = ref.watch(bookListProvider);

    return bookListState.when(
      data: (books) {
        if (books.isEmpty) {
          return const Center(child: Text('No books available'));
        }

        return RefreshIndicator(
          onRefresh: () async {
            ref.read(bookListProvider.notifier).refresh();
          },
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: EdgeInsets.all(16.w),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    SizedBox(height: 14.h),
                    DefaultText(
                      text: "Book List",
                      fontWeight: FontWeight.w700,
                      fontSize: 24.sp,
                    ),
                    SizedBox(height: 20.h),
                  ]),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _getCrossAxisCount(context),
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 16.h,
                    childAspectRatio: 0.75,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index == books.length) {
                        ref.read(bookListProvider.notifier).loadMoreBooks();
                        return const ShimmerSkeletonGridTile();
                      }

                      final book = books[index];
                      return _buildBookTile(book);
                    },
                    childCount: books.length +
                        (ref.read(bookListProvider.notifier).hasMoreBooks
                            ? 1
                            : 0),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(bottom: 16.h),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    if (screenWidth > 1200) {
      return 6;
    } else if (screenWidth > 900) {
      return 5;
    } else if (screenWidth > 600) {
      return 4;
    } else if (screenWidth > 400) {
      return 3;
    } else {
      return 2;
    }
  }

  Widget _buildBookTile(Book book) {
    return GridTile(
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
    );
  }
}
