import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants/api/shimmer.dart';


class HorizontalMovieListShimmerEffect extends StatelessWidget {
  const HorizontalMovieListShimmerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 200,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 5,
                ),
                child: SizedBox(
                  width: width * 0.4,
                  height: height * 0.25,
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
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
