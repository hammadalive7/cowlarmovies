import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'movie_model.dart';

part 'upcoming_movies.g.dart';

@immutable
@JsonSerializable()
class UpcomingMoviesResponse {
  final int page;
  final List<Movie> results;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @JsonKey(name: 'total_results')
  final int totalResults;

  const UpcomingMoviesResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory UpcomingMoviesResponse.fromJson(Map<String, dynamic> json) =>
      _$UpcomingMoviesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpcomingMoviesResponseToJson(this);
}
