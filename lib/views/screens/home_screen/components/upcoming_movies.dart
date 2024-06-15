import 'package:cowlarmovies/controllers/upcoming_controller.dart';
import 'package:cowlarmovies/models/upcoming_movies.dart';
import 'package:cowlarmovies/views/screens/home_screen/components/movie_grid_vertical.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common_components/movie_category_grid_shimmer_skeleton.dart';

class UpcomingMovies extends StatelessWidget {
  const UpcomingMovies({super.key});

  @override
  Widget build(BuildContext context) {
    final UpcomingMoviesController upcomingController =
        Get.find<UpcomingMoviesController>();

    return FutureBuilder<UpcomingMoviesResponse>(
      future: upcomingController.upcomingMoviesList.value,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const GridMovieListShimmerEffect();
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Something went wrong',
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
