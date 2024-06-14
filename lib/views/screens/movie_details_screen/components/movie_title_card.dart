import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../../../../constants/assets.dart';
import '../../../../helpers/process_genre_list.dart';
import '../../../../helpers/process_image_link.dart';
import '../../../../models/genre_model.dart';

class MovieTileWithRating extends StatelessWidget {
  final String? posterPath;
  final String originalTitle;
  final List<Genre>? genres;
  final String? releaseDate;
  final double voteAverage;
  final int movieTime;

  const MovieTileWithRating({
    super.key,
    this.posterPath,
    required this.originalTitle,
    this.genres,
    this.releaseDate,
    required this.movieTime,
    required this.voteAverage,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.context!.textTheme;

    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: FadeInImage.assetNetwork(
            width: width * 0.3,
            height: height * 0.22,
            placeholder: placeholder,
            image: ProcessImage.processImageLink(
              posterPath,
            ),
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 10),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: width * 0.58,
                child: Text(
                  // movieName.length > 20 ? '${movieName.substring(0, 20)}...' : movieName,
                  originalTitle,
                  style: Get.theme.textTheme.titleMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.star_border,
                    color: Colors.grey,
                    size: 16,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    //to 1 decimal
                    voteAverage.toStringAsFixed(1),
                    style: textTheme.titleSmall!.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.movie_creation_outlined,
                    color: Colors.grey,
                    size: 16,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    genres == null ? "" : ProcessGenre.processGenreList(genres).split(',').first,
                    style: textTheme.titleSmall!.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    color: Colors.grey,
                    size: 16,
                  ),
                  const SizedBox(width: 5),
                  Text(
                      releaseDate == null ? "" : releaseDate!.split('-')[0],
                    style: textTheme.titleSmall,
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.watch_later_outlined,
                    color: Colors.grey,
                    size: 16,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    movieTime.toString(),
                    style: textTheme.titleSmall!.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ],
    );
  }
}
