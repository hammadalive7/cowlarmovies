import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/trending_movies.dart';
import '../repositories/trending_movies_repo.dart';

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
      trendingMoviesList.value =
          httpTrendingMoviesRepo.getTrendingMoviesResponse(start);
    } catch (e) {
      debugPrint('Error fetching movies: $e');
    } finally {
      isLoading(false);
    }
  }
}
