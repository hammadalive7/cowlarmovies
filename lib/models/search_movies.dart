import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'movie_model.dart';

part 'search_movies.g.dart';

@immutable
@JsonSerializable()
class SearchMovieResponse {
  final int page;
  final List<Movie> results;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @JsonKey(name: 'total_results')
  final int totalResults;

  const SearchMovieResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory SearchMovieResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchMovieResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchMovieResponseToJson(this);
}
