import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/assets.dart';
import '../../../constants/strings.dart';
import '../../../controllers/movie_details_controller.dart';
import '../../../helpers/process_image_link.dart';
import '../../../models/movie_model.dart';
import '../../theme/theme.dart';
import 'components/details_category_list.dart';
import 'components/movie_details_screen_shimmer.dart';
import 'components/movie_title_card.dart';
import 'components/movie_trailer.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int movieId;


  const MovieDetailsScreen({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put(MovieDetailsController()); // Instantiate the controller

    final textTheme = Get.context!.textTheme;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: dark[800],
      body: FutureBuilder<Movie>(
        future: controller.fetchMovieDetails(movieId),
        // Fetch movie details using the controller method
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MovieDetailsScreenShimmer();
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                wentWrong,
                style: textTheme!.titleMedium,
              ),
            );
          } else {
            final movie = snapshot.data!;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: height * 0.4,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      movie.title,
                      style: textTheme.titleMedium,
                    ),
                    centerTitle: true,
                    background: FadeInImage.assetNetwork(
                      placeholder: placeholder,
                      image: ProcessImage.processPosterLink(
                        movie.backdropPath ?? movie.posterPath,
                      ),
                      fit: BoxFit.cover,
                      width: width,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        width: width,
                        decoration: BoxDecoration(
                          color: dark[800],
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 20,
                          ),
                          child: Obx(() => Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(width: double.infinity),
                              MovieTileWithRating(
                                posterPath: movie.posterPath,
                                originalTitle: movie.originalTitle,
                                genres: movie.genres,
                                releaseDate: movie.releaseDate,
                                voteAverage: movie.voteAverage,
                                movieTime: movie.runtime,
                              ),
                              SizedBox(height: height * 0.02),
                              const DetailCategoriesList(),
                              SizedBox(height: height * 0.01),
                              if (controller.category.value == "About Movie")
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    movie.overview,
                                    style: textTheme.titleSmall,
                                  ),
                                ),
                              if (controller.category.value == "Trailer")
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: MovieTrailer(movieID: movie.id.toString(), movie: movie,)
                                ),
                            ],
                          ),
                        ),
                        )),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
