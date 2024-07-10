

import 'package:cowlarmovies/controllers/mqtt_controller.dart';
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


  Future<void> subscribeCowlarTopic()async {
    final MQTTController mqttController = Get.find<MQTTController>();
    await mqttController.configureAndConnect('cowlar/movie-task');
  }

  Future<void> publishMessage(String message) async {
    final MQTTController mqttController = Get.find<MQTTController>();
    await mqttController.publishMessage(message);
  }


}