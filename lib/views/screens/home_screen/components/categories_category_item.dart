import 'package:cowlarmovies/constants/category_data.dart';
import 'package:cowlarmovies/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesCategoryItem extends StatelessWidget {
  final int index;

  const CategoriesCategoryItem({
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();

    return Obx(() => Center(
      child: Stack(
        children: [
          TextButton(
            onPressed: () {
              homeController.changeCategory(index);
              homeController.category.value = categoryList[index].title;
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 5.0,
                // vertical: 24.0,
              ),
              child: Text(
                categoryList[index].title,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 5.0),
          Positioned(
            bottom: 0,
            left: 15,
            right: 15,
            child: Container(
              height: 2.0,
              width: 40.0,
              color: index == homeController.categoryIndex.value
                  ? Colors.white
                  : Colors.transparent,
            ),
          ),
        ],
      ),
    ));
  }
}
