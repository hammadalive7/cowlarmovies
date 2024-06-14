import 'package:cowlarmovies/controllers/navigation_controller.dart';
import 'package:cowlarmovies/models/trending_movies.dart';
import 'package:cowlarmovies/models/upcoming_movies.dart';
import 'package:flutter/material.dart';
import '../../../constants/strings.dart';
import 'package:get/get.dart';
import '../../../controllers/now_playing_controller.dart';
import '../../../controllers/top_rated_controller.dart';
import '../../../controllers/trending_controller.dart';
import '../../../controllers/upcoming_controller.dart';
import '../../../models/now_playing_movies.dart';
import '../../../models/top_rated_movies.dart';
import '../common_components/movie_list_horizontal_shimmer_skeleton.dart';
import '../common_components/trending_movies.dart';
import '../navigation/navigation_screen.dart';
import 'movie_list_horizontal.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    // final HomeScreenController controller = Get.find<HomeScreenController>();
    final NavigationController navController = Get.find<NavigationController>();
    final NowPlayingMoviesController nowPlayingController =
        Get.find<NowPlayingMoviesController>();
    final TopRatedMoviesController topRatedController =
        Get.find<TopRatedMoviesController>();
    final TrendingMoviesController trendingController =
        Get.find<TrendingMoviesController>();
    final UpcomingMoviesController upcomingController =
        Get.find<UpcomingMoviesController>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.03,
          ),
          child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(appName,
                          style: Theme.of(context).textTheme.headlineSmall),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      navController.changeScreen(1);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NavigationScreen(),
                          ));
                    },
                    child: TextFormField(
                      enabled: false,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                          ),
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.grey[400],
                                ),
                        suffixIcon: const Icon(
                          Icons.search,
                          color: Color(0xFFBDBDBD),
                        ),
                        filled: true,
                        fillColor: const Color(0xFF3A3F47),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const TrendingMovies(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        trendingMovies,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                  FutureBuilder<TrendingMoviesResponse>(
                    future: trendingController.trendingMoviesList.value,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const HorizontalMovieListShimmerEffect();
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Something went wrong',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        );
                      } else if (snapshot.hasData) {
                        final homeScreenResponse = snapshot.data!;
                        return HorizontalMoviesList(
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
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        upcomingMovies,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                  FutureBuilder<UpcomingMoviesResponse>(
                    future: upcomingController.upcomingMoviesList.value,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const HorizontalMovieListShimmerEffect();
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Something went wrong',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        );
                      } else if (snapshot.hasData) {
                        final homeScreenResponse = snapshot.data!;
                        return HorizontalMoviesList(
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
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        nowPlayingMovies,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                  FutureBuilder<NowPlayingMoviesResponse>(
                    future: nowPlayingController.nowPlayingMoviesList.value,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const HorizontalMovieListShimmerEffect();
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            wentWrong,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        );
                      } else if (snapshot.hasData) {
                        final homeScreenResponse = snapshot.data!;
                        return HorizontalMoviesList(
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
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        topRatedMovies,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                  FutureBuilder<TopRatedMoviesResponse>(
                    future: topRatedController.topRatedMoviesList.value,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const HorizontalMovieListShimmerEffect();
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            wentWrong,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        );
                      } else if (snapshot.hasData) {
                        final homeScreenResponse = snapshot.data!;
                        return HorizontalMoviesList(
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
