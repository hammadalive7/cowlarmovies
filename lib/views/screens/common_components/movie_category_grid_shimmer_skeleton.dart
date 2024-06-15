import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../constants/api/shimmer.dart';

class GridMovieListShimmerEffect extends StatelessWidget {
  const GridMovieListShimmerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GridView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: 9,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: (width * 0.4) / (height * 0.25),
      ),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Shimmer(
              direction: ShimmerDirection.ltr,
              gradient: shimmerGradient,
              child: Container(
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
