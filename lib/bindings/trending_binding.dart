import 'package:get/get.dart';

import '../controllers/trending_controller.dart';
import '../repositories/trending_movies_repo.dart';

class TrendingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HttpTrendingMoviesRepo>(() => HttpTrendingMoviesRepo());
    Get.lazyPut<TrendingMoviesController>(() => TrendingMoviesController(Get.find<HttpTrendingMoviesRepo>()));
  }
}