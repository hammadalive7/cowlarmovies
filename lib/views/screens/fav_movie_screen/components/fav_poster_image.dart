import 'package:cached_network_image/cached_network_image.dart';
import 'package:cowlarmovies/constants/assets.dart';
import 'package:cowlarmovies/helpers/process_image_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class PosterImage extends StatelessWidget {
  final String moviePoster;
  static final customCacheManager = CacheManager(
    Config(
      'customCacheKey2',
      stalePeriod: const Duration(days: 2),
      maxNrOfCacheObjects: 200,
    ),
  );

  const PosterImage({super.key, required this.moviePoster});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: CachedNetworkImage(
        placeholder: (context, url) => Image.asset(
          placeholder,
          fit: BoxFit.cover,
        ),
        imageUrl: ProcessImage.processPosterLink(
          moviePoster,
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
    );
  }
}
