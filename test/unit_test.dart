import 'package:cowlarmovies/controllers/bluetooth_controller.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cowlarmovies/constants/mqtt_states.dart';
import 'package:cowlarmovies/controllers/mqtt_controller.dart';

void main() {
  late BluetoothController controller;
  late MQTTController mqttController;

  setUp(() {
    mqttController = MQTTController();
    controller = BluetoothController();
  });

  test('Initial state of BluetoothController', () {
    expect(controller.adapterState.value, BluetoothAdapterState.unknown);
    expect(controller.pairedDevices.isEmpty, true);
  });

  test('Initial values are correct', () {
    expect(mqttController.getReceivedText, '');
    expect(mqttController.getHistoryText, '');
    expect(
        mqttController.getAppConnectionState, MQTTConnectionState.disconnected);
  });

  test('setReceivedText updates received text and history text', () {
    mqttController.setReceivedText('Test message');
    expect(mqttController.getReceivedText, 'Test message');
    expect(mqttController.getHistoryText, '\nTest message');

    mqttController.setReceivedText('Another message');
    expect(mqttController.getReceivedText, 'Another message');
    expect(mqttController.getHistoryText, '\nTest message\nAnother message');
  });

  test('setAppConnectionState updates connection state', () {
    mqttController.setAppConnectionState(MQTTConnectionState.connected);
    expect(mqttController.getAppConnectionState, MQTTConnectionState.connected);

    mqttController.setAppConnectionState(MQTTConnectionState.disconnected);
    expect(
        mqttController.getAppConnectionState, MQTTConnectionState.disconnected);
  });
}
