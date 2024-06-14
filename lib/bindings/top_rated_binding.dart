import 'package:cowlarmovies/repositories/top_rated_movies_repo.dart';
import 'package:get/get.dart';

import '../controllers/top_rated_controller.dart';


class TopRatedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HttpTopRatedMoviesRepo>(() => HttpTopRatedMoviesRepo());
    Get.lazyPut<TopRatedMoviesController>(() => TopRatedMoviesController(Get.find<HttpTopRatedMoviesRepo>()));
  }
}