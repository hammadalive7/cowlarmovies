import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../../../../constants/assets.dart';
import '../../../../helpers/process_image_link.dart';
import '../../../../models/movie_model.dart';
import '../../movie_details_screen/movie_details_screen.dart';

class VerticalMoviesGrid extends StatelessWidget {
  final List<Movie> movies;

  VerticalMoviesGrid({super.key, required this.movies});

  static final customCacheManager = CacheManager(
    Config(
      'customCacheKey',
      stalePeriod: const Duration(days: 2),
      maxNrOfCacheObjects: 200,
    ),
  );

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return SizedBox(
      // height: 200,
      width: double.infinity,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Number of items per row
          childAspectRatio: 2 / 3, // Adjust this ratio as needed
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: movies.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MovieDetailsScreen(
                          movieId: movie.id,
                          movieName: movie.title,
                          moviePosterPath: movie.posterPath ?? '',
                        ),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CachedNetworkImage(
                  placeholder: (context, url) => Image.asset(
                    placeholder,
                    fit: BoxFit.cover,
                  ),
                  imageUrl: ProcessImage.processPosterLink(
                    movie.posterPath,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  key: UniqueKey(),
                  cacheManager: customCacheManager,
                  fit: BoxFit.cover,
                  imageBuilder: (context, imageProvider) => Container(
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
            ),
          );
        },
      ),
    );
  }
}
