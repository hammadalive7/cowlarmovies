import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/strings.dart';
import '../../../controllers/search_controller.dart';
import '../../../helpers/process_image_link.dart';
import '../../../models/search_movies.dart';
import '../../theme/theme.dart';
import '../common_components/movie_card.dart';
import '../common_components/movie_list_shimmer_skeleton.dart';
import '../common_components/process_genre_code.dart';
import '../movie_details_screen/movie_details_screen.dart';


class SearchMoviesScreen extends StatelessWidget {
  const SearchMoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.theme.textTheme;
    final width = MediaQuery.of(context).size.width;
    final SearchMoviesController controller =
        Get.find<SearchMoviesController>();
    final searchBarController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.info_outline),
          ),
        ],
        title: Text(
            "Search",
            style: textTheme.headlineMedium!.copyWith(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.text,
                controller: searchBarController,
                onSubmitted: (value) {
                  controller.updateKeywords(value);
                },
                style: textTheme.titleMedium!.copyWith(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.grey[400],
                      ),
                  suffixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFFBDBDBD),
                  ),
                  filled: true,
                  fillColor: const Color(0xFF3A3F47),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              Expanded(
                child: Obx(() {
                  return FutureBuilder<SearchMovieResponse>(
                    future: controller.searchMovieResponse.value,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const MovieListShimmerEffect();
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            wentWrong,
                            style: textTheme.titleMedium,
                          ),
                        );
                      } else if (snapshot.hasData) {
                        final searchMoviesResponse = snapshot.data!;
                        if (searchMoviesResponse.results.isEmpty) {
                          return Center(
                            child: controller.keywords.value.isEmpty
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.search_rounded,
                                          color: darkAccent, size: 100),
                                      Text(
                                        pleaseSearch,
                                        style: textTheme.titleMedium,
                                      ),
                                    ],
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.not_interested_rounded,
                                          color: darkAccent, size: 100),
                                      Text(
                                        noResultFound,
                                        style: textTheme.titleMedium,
                                      ),
                                    ],
                                  ),
                          );
                        } else {
                          return Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      searchMoviesResponse.results.length,
                                  itemBuilder: (context, i) {
                                    final movie =
                                        searchMoviesResponse.results[i];
                                    return MovieCard(
                                      movieName: movie.title,
                                      moviePoster:
                                          ProcessImage.processImageLink(
                                              movie.posterPath),
                                      movieReleaseDate:
                                          movie.releaseDate.toString(),
                                      movieRating: movie.voteAverage.toString(),
                                      movieGenres:
                                          ProcessGenreCode.processGenreCodes(
                                              movie.genreIds),
                                      movieTime: movie.runtime.toString(),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MovieDetailsScreen(
                                              movieId: movie.id,
                                              movieName: movie.title,
                                              moviePosterPath: movie.posterPath ?? '',
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        }
                      } else {
                        return Center(
                          child: Text(
                            'No data available',
                            style: textTheme.titleMedium,
                          ),
                        );
                      }
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
