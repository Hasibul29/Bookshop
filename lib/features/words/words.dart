import 'package:bookshop/common/default_appbar.dart';
import 'package:bookshop/features/words/database/words_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/default_text.dart';
import '../bookmark/provider/bookmark_provider.dart';
import 'provider/words_provider.dart';

class Words extends ConsumerWidget {
  final LevelsEntity level;
  const Words({super.key, required this.level});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wordsData = ref.watch(wordsByLevelProvider(level.levelNum));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppBar(
        title: "Level ${level.levelNum}",
      ),
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
                    DefaultText(
                      text: level.levelTitle,
                      fontWeight: FontWeight.w700,
                      fontSize: 24.sp,
                      maxLines: 5,
                      height: 30,
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
                          child: InkWell(
                            onLongPress: () async {
                              await ref
                                  .read(bookmarkNotifierProvider.notifier)
                                  .toggleWordBookmark(
                                      words[index].serialNum, false);

                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    elevation: 20,
                                    content: Text('Word added to bookmark.'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  DefaultText(
                                    align: TextAlign.center,
                                    text: words[index].arabic,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    maxLines: 10,
                                  ),
                                  SizedBox(height: 2.h),
                                  DefaultText(
                                    align: TextAlign.center,
                                    text: words[index].english,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    maxLines: 10,
                                  ),
                                ],
                              ),
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
                padding: EdgeInsets.only(bottom: 60.h),
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
