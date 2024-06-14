

import 'package:get/get.dart';

class HomeController extends GetxController {

  RxInt categoryIndex = 0.obs;
  RxString category = "Now playing".obs;

  void changeCategory(int index) {
    categoryIndex.value = index;
  }

  void reset() {
    categoryIndex.value = 0;
  }

}