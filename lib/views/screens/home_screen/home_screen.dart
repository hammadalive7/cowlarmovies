import 'package:cowlarmovies/controllers/navigation_controller.dart';
import 'package:cowlarmovies/models/trending_movies.dart';
import 'package:cowlarmovies/models/upcoming_movies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../constants/category_data.dart';
import '../../../constants/strings.dart';
import 'package:get/get.dart';
import '../../../controllers/home_controller.dart';
import '../../../controllers/now_playing_controller.dart';
import '../../../controllers/top_rated_controller.dart';
import '../../../controllers/trending_controller.dart';
import '../../../controllers/upcoming_controller.dart';
import '../../../models/now_playing_movies.dart';
import '../../../models/top_rated_movies.dart';
import '../common_components/movie_category_grid_shimmer_skeleton.dart';
import '../common_components/movie_horizontal_list_shimmer_skeleton.dart';
import 'components/trending_movies.dart';
import '../navigation/navigation_screen.dart';
import 'components/categories_category_item.dart';
import 'components/categories_category_list.dart';
import 'components/movie_grid_vertical.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    final HomeController homeController = Get.find<HomeController>();
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
              child: Obx(() => Column(
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
                  const CategoriesList(),

                  if(homeController.category.value == trendingMovies)
                    FutureBuilder<TrendingMoviesResponse>(
                    future: trendingController.trendingMoviesList.value,
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
                  ),

                  if(homeController.category.value == upcomingMovies)
                    FutureBuilder<UpcomingMoviesResponse>(
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
                  ),
                  if(homeController.category.value == nowPlayingMovies)
                    FutureBuilder<NowPlayingMoviesResponse>(
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
                  ),

                  if(homeController.category.value == topRatedMovies)
                    FutureBuilder<TopRatedMoviesResponse>(
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
