import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import '../../../constants/assets.dart';
import '../../../controllers/fav_movie_controller.dart';
import '../../../helpers/process_image_link.dart';
import '../movie_details_screen/movie_details_screen.dart';

class FavoriteMoviesGrid extends StatelessWidget {
  static final customCacheManager = CacheManager(
    Config(
      'customCacheKey2',
      stalePeriod: const Duration(days: 2),
      maxNrOfCacheObjects: 200,
    ),
  );

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
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: CachedNetworkImage(
                            placeholder: (context, url) => Image.asset(
                              placeholder,
                              fit: BoxFit.cover,
                            ),
                            imageUrl: ProcessImage.processPosterLink(
                              movie.posterPath,
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            key: UniqueKey(),
                            cacheManager: customCacheManager,
                            fit: BoxFit.cover,
                            imageBuilder: (context, imageProvider) =>
                                Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
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
