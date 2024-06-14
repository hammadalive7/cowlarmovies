import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'genre_model.dart';


part 'movie_model.g.dart';


@immutable
@JsonSerializable()
class Movie {
  final bool adult;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @JsonKey(name: 'belonAgs_to_collection')
  final dynamic belongsToCollection;
  final int? budget;
  final List<Genre>? genres;
  final String? homepage;
  final int id;
  @JsonKey(name: 'imdb_id')
  final String? imdbId;
  @JsonKey(name: 'original_language')
  final String originalLanguage;
  @JsonKey(name: 'original_title')
  final String originalTitle;
  final String overview;
  final double popularity;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'release_date')
  final String? releaseDate;
  final int? revenue;
  @JsonKey(name: 'runtime', defaultValue: 0)
  final int runtime;
  final String? status;
  final String? tagline;
  final String title;
  final bool? video;
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @JsonKey(name: 'vote_count')
  final int voteCount;
  @JsonKey(name: 'genre_ids')
  final List<int>? genreIds;

  const Movie({
    required this.adult,
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    required this.id,
    this.imdbId,
    required this.originalTitle,
    required this.originalLanguage,
    required this.overview,
    required this.popularity,
    this.posterPath,
    this.releaseDate,
    this.revenue,
    required this.runtime,
    this.status,
    this.tagline,
    required this.title,
    this.video,
    required this.voteAverage,
    required this.voteCount,
    this.genreIds,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);
}
