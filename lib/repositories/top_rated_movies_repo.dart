import '../models/top_rated_movies.dart';
import '../services/client/base_client.dart';

abstract class TopRatedMoviesRepo {
  Future<TopRatedMoviesResponse> getTopRatedMoviesResponse([int page = 1]);
}

class HttpTopRatedMoviesRepo implements TopRatedMoviesRepo {

  @override
  Future<TopRatedMoviesResponse> getTopRatedMoviesResponse(
      [int page = 1]) async {
    TopRatedMoviesResponse popularMoviesResponse;
    final String uri =
        '/movie/top_rated?language=en-US&page=${page.toString()}';
    final Map<String, dynamic> response = await BaseClient().get(uri);
    // debugPrint(response.toString());
    popularMoviesResponse = TopRatedMoviesResponse.fromJson(response);
    return popularMoviesResponse;
  }
}
