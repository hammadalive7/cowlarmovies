import 'package:cowlarmovies/views/screens/fav_movie_screen/components/fav_poster_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/fav_movie_controller.dart';
import '../movie_details_screen/movie_details_screen.dart';

class FavoriteMoviesGrid extends StatelessWidget {

  const FavoriteMoviesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesController = Get.put(FavoritesController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Watch List',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Obx(() {
            if (favoritesController.favoriteMovies.isEmpty) {
              return const Center(
                  child: Text('There is no movie yet!',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)));
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of items per row
                childAspectRatio: 2 / 3, // Adjust this ratio as needed
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: favoritesController.favoriteMovies.length,
              itemBuilder: (context, index) {
                final movie = favoritesController.favoriteMovies[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5.0, vertical: 10.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailsScreen(
                            movieId: movie.id,
                            movieName: movie.title,
                            moviePosterPath: movie.posterPath,
                          ),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        PosterImage(moviePoster: movie.posterPath),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Colors.black45,
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.grey, size: 20),
                              onPressed: () {
                                favoritesController.removeFavorite(movie.id);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
