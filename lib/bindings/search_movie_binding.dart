import 'package:cowlarmovies/controllers/now_playing_controller.dart';
import 'package:get/get.dart';

import '../controllers/search_controller.dart';
import '../repositories/now_playing_movies_repo.dart';
import '../repositories/search_movie_repo.dart';


class SearchMovieBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HttpSearchMovieRepo>(() => HttpSearchMovieRepo());
    Get.lazyPut<SearchMoviesController>(() => SearchMoviesController(Get.find<HttpSearchMovieRepo>()));
  }
}