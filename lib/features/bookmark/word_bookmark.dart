import 'package:bookshop/common/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/default_text.dart';
import 'provider/bookmark_provider.dart';

class WordBookmark extends ConsumerWidget {
  const WordBookmark({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wordsData = ref.watch(getBookmarkedWord);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const DefaultAppBar(title: "Words"),
      body: wordsData.when(
        data: (words) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: EdgeInsets.all(16.w),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    SizedBox(height: 14.h),
                    const DefaultText(
                      text: "Bookmarked Words",
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                    SizedBox(height: 10.h),
                  ]),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              color: Colors.black.withOpacity(0.15),
                            )
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: ListTile(
                            leading: DefaultText(
                              align: TextAlign.center,
                              text: words[index].serialNum.toString(),
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                            title: DefaultText(
                              text: words[index].serialNum.toString(),
                              maxLines: 2,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () async {
                                await ref
                                    .read(bookmarkNotifierProvider.notifier)
                                    .toggleWordBookmark(
                                        words[index].serialNum, true);
                              },
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: words.length,
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(bottom: 20.h),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
