// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'now_playing_movies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NowPlayingMoviesResponse _$NowPlayingMoviesResponseFromJson(
        Map<String, dynamic> json) =>
    NowPlayingMoviesResponse(
      page: (json['page'] as num).toInt(),
      results: (json['results'] as List<dynamic>)
          .map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: (json['total_pages'] as num).toInt(),
      totalResults: (json['total_results'] as num).toInt(),
      dates: Map<String, String>.from(json['dates'] as Map),
    );

Map<String, dynamic> _$NowPlayingMoviesResponseToJson(
        NowPlayingMoviesResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
      'dates': instance.dates,
    };
