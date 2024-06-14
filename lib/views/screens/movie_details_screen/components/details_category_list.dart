import 'package:flutter/material.dart';
import '../../../../constants/details_list_data.dart';
import 'detail_category_item.dart';

class DetailCategoriesList extends StatelessWidget {

  const DetailCategoriesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.05,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: detailCategoryList.length,
        itemBuilder: (context, index) {
          return DetailCategoryItem(index: index);
        },
      ),
    );
  }
}
