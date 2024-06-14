import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/top_rated_movies.dart';
import '../services/client/base_client.dart';

abstract class TopRatedMoviesRepo {
  Future<TopRatedMoviesResponse> getTopRatedMoviesResponse([int page = 1]);
}

class TopRatedMoviesController extends GetxController
    implements TopRatedMoviesRepo {

  var isLoading = true.obs;
  var topRatedMoviesList = Rxn<Future<TopRatedMoviesResponse>>();

  @override
  void onInit() {
    super.onInit();
    fetchTopRatedMovies(1);
  }

  @override
  Future<TopRatedMoviesResponse> getTopRatedMoviesResponse(
      [int page = 1]) async {
    TopRatedMoviesResponse popularMoviesResponse;
    final String uri =
        '/movie/top_rated?language=en-US&page=${page.toString()}';
    final Map<String, dynamic> response = await BaseClient().get(uri);
    debugPrint(response.toString());
    popularMoviesResponse = TopRatedMoviesResponse.fromJson(response);
    return popularMoviesResponse;
  }

  Future<void> fetchTopRatedMovies(int start) async {
    try {
      isLoading(true);
      topRatedMoviesList.value = getTopRatedMoviesResponse(start);
    } catch (e) {
      print('Error fetching movies: $e');
    } finally {
      isLoading(false);
    }
  }
}
