import 'package:cowlarmovies/constants/strings.dart';
import 'package:cowlarmovies/controllers/now_playing_controller.dart';
import 'package:cowlarmovies/models/now_playing_movies.dart';
import 'package:cowlarmovies/views/screens/common_components/movie_category_grid_shimmer_skeleton.dart';
import 'package:cowlarmovies/views/screens/home_screen/components/movie_grid_vertical.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NowPlayingMovies extends StatelessWidget {
  const NowPlayingMovies({super.key});

  @override
  Widget build(BuildContext context) {
    final NowPlayingMoviesController nowPlayingController =
        Get.find<NowPlayingMoviesController>();
    return FutureBuilder<NowPlayingMoviesResponse>(
      future: nowPlayingController.nowPlayingMoviesList.value,
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
