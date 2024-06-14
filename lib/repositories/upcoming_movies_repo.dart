

import 'package:cowlarmovies/services/client/base_client.dart';

import '../models/upcoming_movies.dart';

abstract class UpcomingMoviesRepo {
  Future<UpcomingMoviesResponse> getUpcomingMoviesResponse([int page = 1]);
}

class HttpUpcomingMoviesRepo implements UpcomingMoviesRepo {
  @override
  Future<UpcomingMoviesResponse> getUpcomingMoviesResponse(
      [int page = 1]) async {
    UpcomingMoviesResponse upcomingMoviesResponse;
    final String uri =
        '/movie/upcoming?language=en-US&page=${page.toString()}';
    final Map<String, dynamic> response = await BaseClient().get(uri);
    // debugPrint(response.toString());
    upcomingMoviesResponse = UpcomingMoviesResponse.fromJson(response);
    return upcomingMoviesResponse;
  }
}
