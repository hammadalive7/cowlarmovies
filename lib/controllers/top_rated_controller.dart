import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/top_rated_movies.dart';
import '../repositories/top_rated_movies_repo.dart';
import '../services/client/base_client.dart';

class TopRatedMoviesController extends GetxController {

  final HttpTopRatedMoviesRepo httpTopRatedMoviesRepo;

  TopRatedMoviesController(this.httpTopRatedMoviesRepo);

  var isLoading = true.obs;
  var topRatedMoviesList = Rxn<Future<TopRatedMoviesResponse>>();

  @override
  void onInit() {
    super.onInit();
    fetchTopRatedMovies(1);
  }

  Future<void> fetchTopRatedMovies(int start) async {
    try {
      isLoading(true);
      topRatedMoviesList.value =
          httpTopRatedMoviesRepo.getTopRatedMoviesResponse(start);
    } catch (e) {
      print('Error fetching movies: $e');
    } finally {
      isLoading(false);
    }
  }
}
