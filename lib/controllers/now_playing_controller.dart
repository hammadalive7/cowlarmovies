import 'package:get/get.dart';
import '../models/now_playing_movies.dart';
import '../repositories/now_playing_movies_repo.dart';


class NowPlayingMoviesController extends GetxController
     {

  final NowPlayingMoviesRepo nowPlayingMoviesRepo;

  NowPlayingMoviesController(this.nowPlayingMoviesRepo);

  var isLoading = true.obs;
  var nowPlayingMoviesList = Rxn<Future<NowPlayingMoviesResponse>>();

  @override
  void onInit() {
    super.onInit();
    fetchNowPlayingMovies(1);
  }


  Future<void> fetchNowPlayingMovies(int start) async {
    try {
      isLoading(true);
      nowPlayingMoviesList.value = nowPlayingMoviesRepo.getNowPlayingMoviesResponse(start);
    } catch (e) {
      // print('Error fetching movies: $e');
    } finally {
      isLoading(false);
    }
  }
}
