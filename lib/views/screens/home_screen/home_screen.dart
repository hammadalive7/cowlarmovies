import 'package:cowlarmovies/controllers/navigation_controller.dart';
import 'package:cowlarmovies/models/trending_movies.dart';
import 'package:cowlarmovies/models/upcoming_movies.dart';
import 'package:cowlarmovies/views/screens/home_screen/components/popular_movies.dart';
import 'package:cowlarmovies/views/screens/home_screen/components/search_movies.dart';
import 'package:cowlarmovies/views/screens/home_screen/components/top_rated_movies.dart';
import 'package:cowlarmovies/views/screens/home_screen/components/upcoming_movies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
import 'components/now_playing_movies.dart';
import 'components/trending_movies.dart';
import '../navigation/navigation_screen.dart';
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
    final trendingController = Get.find<TrendingMoviesController>();

    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.03,
        ),
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(appName,
                          style: Theme.of(context).textTheme.headlineSmall),
                      //refresh icon
                      GestureDetector(
                          onTap: () {
                            trendingController.onInit();
                          },
                          child: const Icon(
                            Icons.refresh,
                            size: 25,
                            color: Colors.white,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  const SearchMovies(),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  const TrendingMovies(),
                  const CategoriesList(),
                  if (homeController.category.value == trendingMovies)
                    const PopularMovies(),
                  if (homeController.category.value == upcomingMovies)
                    const UpcomingMovies(),
                  if (homeController.category.value == nowPlayingMovies)
                    const NowPlayingMovies(),
                  if (homeController.category.value == topRatedMovies)
                    const TopRatedMovies(),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
