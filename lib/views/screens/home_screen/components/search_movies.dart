import 'package:cowlarmovies/controllers/navigation_controller.dart';
import 'package:cowlarmovies/views/screens/navigation/navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchMovies extends StatelessWidget {
  const SearchMovies({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController navController = Get.find<NavigationController>();

    return InkWell(
      onTap: () {
        navController.changeScreen(1);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NavigationScreen(),
            ));
      },
      child: TextFormField(
        enabled: false,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
            ),
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.grey[400],
              ),
          suffixIcon: const Icon(
            Icons.search,
            color: Color(0xFFBDBDBD),
          ),
          filled: true,
          fillColor: const Color(0xFF3A3F47),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
