import 'package:get/get.dart';
import '../models/search_movies.dart';
import '../services/client/base_client.dart';

abstract class SearchMovieRepo {
  Future<SearchMovieResponse> searchMovieWithKeywords(String keywords,int pageNumber);
}

class SearchMoviesController extends GetxController implements SearchMovieRepo {

  var searchMovieResponse = Rxn<Future<SearchMovieResponse>>();
  var pageNumber = 1.obs;
  var keywords = ''.obs;

  @override
  Future<SearchMovieResponse> searchMovieWithKeywords(String keywords,int pageNumber) async {
    SearchMovieResponse searchMovieWithKeywordResponse;
    final String uri = '/search/movie?query=$keywords&language=en-US&page=$pageNumber&include_adult=false';
    final Map<String, dynamic> response = await BaseClient().get(uri);
    searchMovieWithKeywordResponse = SearchMovieResponse.fromJson(response);
    return searchMovieWithKeywordResponse;
  }

  void updateKeywords(String newKeywords) {
    keywords(newKeywords);
    pageNumber(1); // Reset to first page when keywords change
    fetchSearchMovies();
  }

  // void updatePageNumber(int newPageNumber) {
  //   pageNumber(newPageNumber);
  //   fetchSearchMovies();
  // }

  Future<void> fetchSearchMovies() async {
    searchMovieResponse.value =  searchMovieWithKeywords(
        keywords.value, pageNumber.value);
  }

  //dispose
  @override
  void onDispose() {
    super.onClose();
    searchMovieResponse.value = null;
    pageNumber.value = 1;
    keywords.value = '';

  }


}