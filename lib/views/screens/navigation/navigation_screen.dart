import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/utils.dart';
import '../../../controllers/navigation_controller.dart';
import '../fav_movie_screen/fav_movies_screen.dart';
import '../home_screen/home_screen.dart';
import '../search_movies/search_movies.dart';
import 'components/navigation_bottom_bar.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final NavigationController _navigationController =
      Get.find<NavigationController>();

  final List<Widget> _pageList = [
    const HomeScreen(),
    const SearchMoviesScreen(),
     FavoriteMoviesGrid(),
    const HomeScreen(),
    const HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _navigationController.navigationScaffoldKey,
      body: Obx(
        () => SizedBox(
          height: DeviceUtils.getHeight(context),
          child: _pageList[_navigationController.selectedIndex.value],
        ),
      ),
      bottomNavigationBar: const NavigationBottomBar(),
      extendBody: true,
    );
  }
}
