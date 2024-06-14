// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeScreenResponse _$HomeScreenResponseFromJson(Map<String, dynamic> json) =>
    HomeScreenResponse(
      success: json['success'] as bool,
      trendingMovies: (json['popular'] as List<dynamic>)
          .map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList(),
      nowPlayingMovies: (json['now_playing'] as List<dynamic>)
          .map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList(),
      topRatedMovies: (json['top_rated'] as List<dynamic>)
          .map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeScreenResponseToJson(HomeScreenResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'popular': instance.trendingMovies,
      'now_playing': instance.nowPlayingMovies,
      'top_rated': instance.topRatedMovies,
    };
