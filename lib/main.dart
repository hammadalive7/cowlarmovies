import 'package:cowlarmovies/views/screens/navigation/navigation_screen.dart';
import 'package:cowlarmovies/views/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'constants/strings.dart';
import 'controllers/home_contoller.dart';
import 'controllers/navigation_controller.dart';
import 'controllers/now_playing_controller.dart';
import 'controllers/search_controller.dart';
import 'controllers/top_rated_controller.dart';
import 'views/screens/home_screen/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Get
    ..put(NavigationController())
    ..put(HomeScreenController())
    ..put(NowPlayingMoviesController())
    ..put(TopRatedMoviesController())
    ..put(SearchMoviesController());

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
      home: NavigationScreen(),
    );
  }
}
