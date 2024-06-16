import 'package:cowlarmovies/models/search_movies.dart';
import 'package:cowlarmovies/models/top_rated_movies.dart';
import 'package:cowlarmovies/models/trending_movies.dart';
import 'package:cowlarmovies/repositories/search_movie_repo.dart';
import 'package:cowlarmovies/repositories/top_rated_movies_repo.dart';
import 'package:cowlarmovies/repositories/trending_movies_repo.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'api_test.mocks.dart';

@GenerateMocks([http.Client])
Future<void> main() async {
  await dotenv.load(fileName: '.env');

  group('fetchMovies', () {

    test('returns an Top Rated Movies if the http call completes successfully',
        () async {
      final client = MockClient();

      when(client.get(Uri.parse(
              '${dotenv.env['BASEURL']!}/movie/top_rated?api_key=${dotenv.env['APIKEY']!}&language=en-US&page=1')))
          .thenAnswer((_) async => http.Response("{'results': [], 'total_pages': 1, 'total_results': 10, 'page': 1}", 200));

      final repo = HttpTopRatedMoviesRepo();

      final result = await repo.getTopRatedMoviesResponse(1);

      expect(
          result, isA<TopRatedMoviesResponse>());
    });

    test('returns an Trending Movies if the http call completes successfully',
            () async {
          final client = MockClient();

          when(client.get(Uri.parse(
              '${dotenv.env['BASEURL']!}/movie/trending/movie/day?language=en-US&page=1?api_key=${dotenv.env['APIKEY']!}')))
              .thenAnswer((_) async => http.Response("{'results': [], 'total_pages': 1, 'total_results': 10, 'page': 1}", 200));

          final trendingRepo = HttpTrendingMoviesRepo();

          final result = await trendingRepo.getTrendingMoviesResponse(1);

          expect(
              result, isA<TrendingMoviesResponse>());
        });

    test('returns an searched Movies if the http call completes successfully',
            () async {
          final client = MockClient();

          when(client.get(Uri.parse(
              '${dotenv.env['BASEURL']!}/search/movie?query=Spider&include_adult=false&language=en-US&page=1?api_key=${dotenv.env['APIKEY']!}')))
              .thenAnswer((_) async => http.Response("{'results': [], 'total_pages': 1, 'total_results': 10, 'page': 1}", 200));

          final searchRepo = HttpSearchMovieRepo();

          final result = await searchRepo.searchMovieWithKeywords("Spider", 1);

          expect(
              result, isA<SearchMovieResponse>());
        });

  });

}
