


import 'package:cowlarmovies/models/search_movies.dart';

import '../services/client/base_client.dart';

abstract class SearchMovieRepo {
  Future<SearchMovieResponse> searchMovieWithKeywords(String keywords,int pageNumber);
}

class HttpSearchMovieRepo extends SearchMovieRepo {
  @override
  Future<SearchMovieResponse> searchMovieWithKeywords(String keywords,int pageNumber) async {
    SearchMovieResponse searchMovieWithKeywordResponse;
    final String uri = '/search/movie?query=$keywords&language=en-US&page=$pageNumber&include_adult=false';
    final Map<String, dynamic> response = await BaseClient().get(uri);
    searchMovieWithKeywordResponse = SearchMovieResponse.fromJson(response);
    return searchMovieWithKeywordResponse;
  }
}
