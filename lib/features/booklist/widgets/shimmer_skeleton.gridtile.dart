import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerSkeletonGridTile extends StatelessWidget {
  const ShimmerSkeletonGridTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: GridTile(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
