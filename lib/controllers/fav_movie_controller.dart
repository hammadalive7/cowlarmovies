import 'package:get/get.dart';
import '../helpers/fav_db_helper.dart';
import '../models/fav_movie_model.dart';

class FavoritesController extends GetxController {
  var favoriteMovies = <FavMovie>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  void loadFavorites() async {
    var movies = await DBHelper().getAllMovies();
    favoriteMovies.assignAll(movies);
  }

  void addFavorite(FavMovie movie) async {
    if (!await isFavorite(movie.id)) {
      await DBHelper().insertMovie(movie);
      loadFavorites();
      Get.snackbar('Success', 'Added to Favorites');
    } else {
      Get.snackbar('Alert', 'Already in Favorites');
    }
  }

  void removeFavorite(int movieId) async {
    await DBHelper().removeMovie(movieId);
    loadFavorites();
    // Get.snackbar('Success', 'Removed from Favorites');
  }

  Future<bool> isFavorite(int movieId) async {
    var movie = await DBHelper().getMovieById(movieId);
    return movie != null;
  }
}
