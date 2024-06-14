import 'package:get/get.dart';
import '../models/search_movies.dart';
import '../repositories/search_movie_repo.dart';
import '../services/client/base_client.dart';



class SearchMoviesController extends GetxController {

  final HttpSearchMovieRepo _searchMovieRepo;

  SearchMoviesController(this._searchMovieRepo);

  var searchMovieResponse = Rxn<Future<SearchMovieResponse>>();
  var pageNumber = 1.obs;
  var keywords = ''.obs;

  void updateKeywords(String newKeywords) {
    keywords(newKeywords);
    pageNumber(1); // Reset to first page when keywords change
    fetchSearchMovies();
  }

  Future<void> fetchSearchMovies() async {
    searchMovieResponse.value =  _searchMovieRepo.searchMovieWithKeywords(
        keywords.value, pageNumber.value);
  }

  @override
  void onClose() {
    super.onClose();
    searchMovieResponse.value = null;
    pageNumber.value = 1;
    keywords.value = '';
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