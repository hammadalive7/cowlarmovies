import 'package:get/get.dart';
import '../models/movie_model.dart';
import '../repositories/movie_details_repo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieDetailsController extends GetxController {


  RxInt categoryIndex = 0.obs;
  RxString category = "About Movie".obs;
  List movieTrailer = [];
  RxString trailerYouTubeID = ''.obs;

  void changeCategory(int index) {
    categoryIndex.value = index;
  }

  void reset() {
    categoryIndex.value = 0;
  }

  final MovieDetailsRepo _movieDetailsRepo = HttpMovieDetails();

  Future<Movie> fetchMovieDetails(int id) async {
    try {
      return _movieDetailsRepo.getMovieDetails(id);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getMovieTrailer(String movieID) async {
    String baseUrl = 'https://api.themoviedb.org/3/movie/';
    String movieVideos = '/videos?api_key=ae753c450aeeb54164711d62838ed214';
    final url = Uri.parse(baseUrl + movieID + movieVideos);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      movieTrailer = data.values.toList()[1];
      for (var trailer in movieTrailer) {
        if (trailer['name'] == 'Official Trailer') {
            trailerYouTubeID.value = trailer['key'];
          break;
        }
      }
    } else {
      throw Exception('Failed to load movie videos.');
    }
  }
}