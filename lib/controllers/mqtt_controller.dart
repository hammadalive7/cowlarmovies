import 'package:cowlarmovies/constants/mqtt_states.dart';
import 'package:cowlarmovies/controllers/trending_controller.dart';
import 'package:cowlarmovies/services/mqtt_manager.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MQTTController extends GetxController {

  final TextEditingController messageTextController = TextEditingController();
  final TextEditingController topicTextController = TextEditingController();
  late MQTTManager manager;
  String host = 'test.mosquitto.org';
  final _appConnectionState = MQTTConnectionState.disconnected.obs;
  final _receivedText = ''.obs;
  final _historyText = ''.obs;


  void setReceivedText(String text) {
    _receivedText.value = text;
    _historyText.value = '$_historyText\n$_receivedText';
  }

  void setAppConnectionState(MQTTConnectionState state) {
    _appConnectionState.value = state;
  }

  String get getReceivedText => _receivedText.value;
  String get getHistoryText => _historyText.value;
  MQTTConnectionState get getAppConnectionState => _appConnectionState.value;

  Future<void> configureAndConnect(String topic) async {
    // ignore: flutter_style_todos
    // TODO: Use UUID
    String osPrefix = await generateMobileUniqueId();

    manager = MQTTManager(
        host: host,
        topic: topic,
        identifier: osPrefix,
        state: this);
    manager.initializeMQTTClient();
    manager.connect();
  }

  void disconnect() {
    manager.disconnect();
  }

  Future<void> publishMessage(String text) async {
    String osPrefix = await generateMobileUniqueId();

    final String message = '$osPrefix: $text';
    manager.publish(message);
    messageTextController.clear();
  }

  Future<void> handleReceivedMessage(String text) async {
    if (text.contains("refresh")) {
      final TrendingMoviesController trendingController =
      Get.find<TrendingMoviesController>();
      trendingController.onInit();
    }
  }

  Future<String> generateMobileUniqueId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceID = await deviceInfo.androidInfo.then((value) => value.androidId);
    return deviceID;
  }

}
