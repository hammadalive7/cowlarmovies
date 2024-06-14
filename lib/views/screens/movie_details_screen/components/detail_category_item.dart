import 'package:cowlarmovies/constants/category_data.dart';
import 'package:cowlarmovies/controllers/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../constants/details_list_data.dart';
import '../../../../controllers/movie_details_controller.dart';

class DetailCategoryItem extends StatelessWidget {
  final int index;

  const DetailCategoryItem({
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final MovieDetailsController detailController = Get.find<MovieDetailsController>();

    return Obx(() => Center(
      child: Stack(
        children: [
          TextButton(
            onPressed: () {
              detailController.changeCategory(index);
              detailController.category.value = detailCategoryList[index].title;
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 5.0,
                // vertical: 24.0,
              ),
              child: Text(
                detailCategoryList[index].title,
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
              color: index == detailController.categoryIndex.value
                  ? Colors.white
                  : Colors.transparent,
            ),
          ),
        ],
      ),
    ));
  }
}
