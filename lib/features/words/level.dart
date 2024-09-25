import 'package:bookshop/features/words/words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/default_text.dart';
import '../bookmark/provider/bookmark_provider.dart';
import 'provider/words_provider.dart';

class WordsLevel extends ConsumerWidget {
  const WordsLevel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final levelsData = ref.watch(levelsProvider);

    return levelsData.when(
      data: (levels) {
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: EdgeInsets.all(16.w),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(height: 14.h),
                  DefaultText(
                    text: "Levels",
                    fontWeight: FontWeight.w700,
                    fontSize: 24.sp,
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
                    final isBookmarked = ref.watch(
                        getBookmarkByLevelIdProvider(levels[index].levelNum));
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
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Words(level: levels[index]),
                                ),
                              );
                            },
                            leading: DefaultText(
                              align: TextAlign.center,
                              text: levels[index].levelNum.toString(),
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                            title: DefaultText(
                              text: levels[index].levelTitle,
                              maxLines: 2,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                isBookmarked.maybeWhen(
                                  data: (bookmarked) => bookmarked != null
                                      ? Icons.star
                                      : Icons.star_border_outlined,
                                  orElse: () => Icons.star_border_outlined,
                                ),
                                color: isBookmarked.maybeWhen(
                                  data: (bookmarked) =>
                                      bookmarked != null ? Colors.green : null,
                                  orElse: () => null,
                                ),
                              ),
                              onPressed: () async {
                                final isBookmarkedValue =
                                    isBookmarked.maybeWhen(
                                  data: (bookmarked) => bookmarked != null,
                                  orElse: () => false,
                                );

                                await ref
                                    .read(bookmarkNotifierProvider.notifier)
                                    .toggleBookmark(levels[index].levelNum,
                                        isBookmarkedValue);
                              },
                            ),
                          )),
                    );
                  },
                  childCount: levels.length,
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
    );
  }
}
