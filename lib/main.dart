import 'package:cowlarmovies/bindings/upcoming_binding.dart';
import 'package:cowlarmovies/views/screens/navigation/navigation_screen.dart';
import 'package:cowlarmovies/views/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bindings/now_playing_binding.dart';
import 'bindings/search_movie_binding.dart';
import 'bindings/top_rated_binding.dart';
import 'bindings/trending_binding.dart';
import 'constants/strings.dart';
import 'controllers/home_controller.dart';
import 'controllers/movie_details_controller.dart';
import 'controllers/navigation_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: theme(),
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => NavigationController());
        Get.lazyPut(() => HomeController());
        Get.lazyPut(() => MovieDetailsController());
        TopRatedBinding().dependencies();
        NowPlayingBinding().dependencies();
        SearchMovieBinding().dependencies();
        TrendingBinding().dependencies();
        UpcomingMovieBinding().dependencies();
      }),
      home: NavigationScreen(),
    );
  }
}
