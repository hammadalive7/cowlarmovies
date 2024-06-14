import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../../../constants/assets.dart';
import '../../../helpers/process_image_link.dart';
import '../../../models/movie_model.dart';
import '../../theme/theme.dart';

class TrendingHorizontalMoviesList extends StatelessWidget {
  final List<Movie> movies;

  TrendingHorizontalMoviesList({super.key, required this.movies});

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
      height: height * 0.35,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: InkWell(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) =>
                //         MovieDetailsScreen(
                //           movieId: movie.id,
                //         ),
                //   ),
                // );
              },
              child: Stack(
                children: [
                  SizedBox(
                    width: width * 0.38,
                    height: height * 0.25,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
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
                            imageBuilder: (context, imageProvider) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0,
                        shadows: [
                          Shadow(
                            blurRadius: 1.0,
                            color: Color(0xFF0296E5),
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                        color: Colors.white,
                        fontSize: 110.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
