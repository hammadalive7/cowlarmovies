import 'package:cowlarmovies/bindings/upcoming_binding.dart';
import 'package:cowlarmovies/services/shared_preferences.dart';
import 'package:cowlarmovies/views/screens/navigation/navigation_screen.dart';
import 'package:cowlarmovies/views/screens/splash_screen/splash_screen.dart';
import 'package:cowlarmovies/views/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'bindings/now_playing_binding.dart';
import 'bindings/search_movie_binding.dart';
import 'bindings/top_rated_binding.dart';
import 'bindings/trending_binding.dart';
import 'constants/strings.dart';
import 'controllers/fav_movie_controller.dart';
import 'controllers/home_controller.dart';
import 'controllers/movie_details_controller.dart';
import 'controllers/navigation_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<Widget> checkIfOpenedBefore() async {
    bool openedBefore = await SharedPreferenceServiceImpl().ifOpenedBefore();
    if (openedBefore) {
      return const NavigationScreen();
    } else {
      await SharedPreferenceServiceImpl().setOpenedBeforeTrue();
      return const SplashScreen();
    }
  }

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
        Get.lazyPut(() => FavoritesController());

      }),
      home: FutureBuilder(
        future: checkIfOpenedBefore(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data as Widget;
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: darkAccent,
              ),
            );
          }
        },
      ),
    );
  }
}
