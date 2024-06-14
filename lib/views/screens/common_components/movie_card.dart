import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/assets.dart';
import '../../theme/theme.dart';

class MovieCard extends StatelessWidget {
  final String movieName;
  final String moviePoster;
  final String movieReleaseDate;
  final String movieRating;
  final String movieTime;
  final List<String> movieGenres;
  final Function() onTap;

  const MovieCard({
    super.key,
    required this.movieName,
    required this.moviePoster,
    required this.movieReleaseDate,
    required this.movieRating,
    required this.movieGenres,
    required this.movieTime,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.theme.textTheme;
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: height * 0.21,
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: dark[800],
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage.assetNetwork(
                      placeholder: placeholder,
                      image: moviePoster,
                      fit: BoxFit.cover,
                      height: height * 0.2,
                      width: width * 0.3,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(placeholder);
                      }),
                ),
              ),
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
                        movieName,
                        style: Get.theme.textTheme.titleMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.star_border,
                          color: Colors.orange,
                          size: 16,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          //to 1 decimal
                          movieRating.substring(0, 3),
                          style: textTheme.titleSmall!.copyWith(
                            color: Colors.orange,
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
                          movieGenres.isEmpty ? "" : movieGenres[0].toString(),
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
                          movieReleaseDate.split('-')[0],
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
          ),
        ),
      ),
    );
  }
}
