

import 'package:get/get.dart';

import '../models/trending_movies.dart';
import '../repositories/trending_movies_repo.dart';
import '../services/client/base_client.dart';



class TrendingMoviesController extends GetxController {

  final HttpTrendingMoviesRepo httpTrendingMoviesRepo;

  TrendingMoviesController(this.httpTrendingMoviesRepo);

  var isLoading = true.obs;
  var trendingMoviesList = Rxn<Future<TrendingMoviesResponse>>();

  @override
  void onInit() {
    super.onInit();
    fetchTrendingMovies(1);
  }






  Future<void> fetchTrendingMovies(int start) async {
    try {
      isLoading(true);
      trendingMoviesList.value = httpTrendingMoviesRepo.getTrendingMoviesResponse(start);
    } catch (e) {
      print('Error fetching movies: $e');
    } finally {
      isLoading(false);
    }
  }

}