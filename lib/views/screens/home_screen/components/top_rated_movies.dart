import 'package:cowlarmovies/constants/strings.dart';
import 'package:cowlarmovies/controllers/top_rated_controller.dart';
import 'package:cowlarmovies/models/top_rated_movies.dart';
import 'package:cowlarmovies/views/screens/common_components/movie_category_grid_shimmer_skeleton.dart';
import 'package:cowlarmovies/views/screens/home_screen/components/movie_grid_vertical.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopRatedMovies extends StatelessWidget {
  const TopRatedMovies({super.key});

  @override
  Widget build(BuildContext context) {
    final TopRatedMoviesController topRatedController =
        Get.find<TopRatedMoviesController>();

    return FutureBuilder<TopRatedMoviesResponse>(
      future: topRatedController.topRatedMoviesList.value,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const GridMovieListShimmerEffect();
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              wentWrong,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          );
        } else if (snapshot.hasData) {
          final homeScreenResponse = snapshot.data!;
          return VerticalMoviesGrid(
            movies: homeScreenResponse.results,
          );
        } else {
          return Center(
            child: Text(
              'No data available',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          );
        }
      },
    );
  }
}
