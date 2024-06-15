import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/upcoming_movies.dart';
import '../repositories/upcoming_movies_repo.dart';

class UpcomingMoviesController extends GetxController {

  final HttpUpcomingMoviesRepo _httpUpcomingMoviesRepo;

  UpcomingMoviesController(this._httpUpcomingMoviesRepo);
  var isLoading = true.obs;
  var upcomingMoviesList = Rxn<Future<UpcomingMoviesResponse>>();

  @override
  void onInit() {
    super.onInit();
    fetchUpcomingMovies(1);
  }

  Future<void> fetchUpcomingMovies(int start) async {
    try {
      isLoading(true);
      upcomingMoviesList.value = _httpUpcomingMoviesRepo.getUpcomingMoviesResponse(start);
    } catch (e) {
      debugPrint('Error fetching movies: $e');
    } finally {
      isLoading(false);
    }
  }
}
