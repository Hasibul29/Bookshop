import 'package:bookshop/common/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/default_text.dart';
import '../booklist/bookdetails.dart';
import '../booklist/widgets/book_gridtile.dart';
import 'provider/bookmark_provider.dart';

class BookBookmark extends ConsumerWidget {
  const BookBookmark({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookListState = ref.watch(getBookmarkedBook);

    return Scaffold(
      appBar: const DefaultAppBar(title: "Books"),
      body: bookListState.when(
          data: (books) {
            if (books.isEmpty) {
              return const Center(child: Text('No books available'));
            }

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.all(16.w),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      SizedBox(height: 14.h),
                      const DefaultText(
                        text: "Bookmarked Books",
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
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
                        return buildBookTile(books[index].toBook(), () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookDetails(
                                book: books[index].toBook(),
                              ),
                            ),
                          );
                        });
                      },
                      childCount: books.length,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(bottom: 16.h),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error'))),
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
}
