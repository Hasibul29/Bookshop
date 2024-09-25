import 'package:bookshop/features/booklist/bookdetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/default_text.dart';
import 'provider/booklist_provider.dart';
import 'widgets/book_gridtile.dart';
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
                    const DefaultText(
                      text: "Book List",
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
                      if (index == books.length) {
                        ref.read(bookListProvider.notifier).loadMoreBooks();
                        return const ShimmerSkeletonGridTile();
                      }
                      return buildBookTile(books[index], () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookDetails(
                              book: books[index],
                            ),
                          ),
                        );
                      });
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
      error: (error, stack) => Center(
        child: IconButton.filled(
            onPressed: () {
              ref.read(bookListProvider.notifier).refresh();
            },
            icon: const Icon(
              Icons.refresh_rounded,
              size: 50,
            )),
      ),
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
