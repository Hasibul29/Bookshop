import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/default_text.dart';
import 'provider/words_provider.dart';

class Words extends ConsumerWidget {
  const Words({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final levelsData = ref.watch((levelsProvider));

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
                    text: "Words",
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
                    return ListTile(
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
