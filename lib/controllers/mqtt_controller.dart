import 'package:cowlarmovies/constants/mqtt_states.dart';
import 'package:get/get.dart';


class MQTTController extends GetxController {

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



}
