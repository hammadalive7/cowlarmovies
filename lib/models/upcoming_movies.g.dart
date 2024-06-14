// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upcoming_movies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpcomingMoviesResponse _$UpcomingMoviesResponseFromJson(
        Map<String, dynamic> json) =>
    UpcomingMoviesResponse(
      page: (json['page'] as num).toInt(),
      results: (json['results'] as List<dynamic>)
          .map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: (json['total_pages'] as num).toInt(),
      totalResults: (json['total_results'] as num).toInt(),
    );

Map<String, dynamic> _$UpcomingMoviesResponseToJson(
        UpcomingMoviesResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };
