import 'package:cowlarmovies/repositories/upcoming_movies_repo.dart';
import 'package:get/get.dart';
import '../controllers/upcoming_controller.dart';


class UpcomingMovieBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HttpUpcomingMoviesRepo>(() => HttpUpcomingMoviesRepo());
    Get.lazyPut<UpcomingMoviesController>(() => UpcomingMoviesController(Get.find<HttpUpcomingMoviesRepo>()));
  }
}