import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/now_playing_movies.dart';
import '../repositories/now_playing_movies_repo.dart';
import '../services/client/base_client.dart';

abstract class NowPlayingMoviesRepo {
  Future<NowPlayingMoviesResponse> getNowPlayingMoviesResponse([int page = 1]);
}

class NowPlayingMoviesController extends GetxController
    implements NowPlayingMoviesRepo {
  var isLoading = true.obs;
  var nowPlayingMoviesList = Rxn<Future<NowPlayingMoviesResponse>>();

  @override
  void onInit() {
    super.onInit();
    fetchNowPlayingMovies(1);
  }

  @override
  Future<NowPlayingMoviesResponse> getNowPlayingMoviesResponse([
    int page = 1,
  ]) async {
    NowPlayingMoviesResponse nowPlayingMoviesResponse;
    final String uri =
        '/movie/now_playing?language=en-US&page=${page.toString()}';
    final Map<String, dynamic> response = await BaseClient().get(uri);
    debugPrint(response.toString());
    nowPlayingMoviesResponse = NowPlayingMoviesResponse.fromJson(response);
    return nowPlayingMoviesResponse;
  }

  Future<void> fetchNowPlayingMovies(int start) async {
    try {
      isLoading(true);
      nowPlayingMoviesList.value = getNowPlayingMoviesResponse(start);
    } catch (e) {
      print('Error fetching movies: $e');
    } finally {
      isLoading(false);
    }
  }
}
