import 'package:cowlarmovies/controllers/now_playing_controller.dart';
import 'package:get/get.dart';

import '../repositories/now_playing_movies_repo.dart';


class NowPlayingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HttpNowPlayingMoviesRepo>(() => HttpNowPlayingMoviesRepo());
    Get.lazyPut<NowPlayingMoviesController>(() => NowPlayingMoviesController(Get.find<HttpNowPlayingMoviesRepo>()));
  }
}