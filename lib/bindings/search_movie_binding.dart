import 'package:get/get.dart';
import '../controllers/search_controller.dart';
import '../repositories/search_movie_repo.dart';


class SearchMovieBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HttpSearchMovieRepo>(() => HttpSearchMovieRepo());
    Get.lazyPut<SearchMoviesController>(() => SearchMoviesController(Get.find<HttpSearchMovieRepo>()));
  }
}