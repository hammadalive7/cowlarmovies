import 'package:cowlarmovies/constants/mqtt_states.dart';
import 'package:cowlarmovies/controllers/mqtt_controller.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MQTTManager {
  final MQTTController _currentState;
  MqttServerClient? _client;
  final String _identifier;
  final String _host;
  final String _topic;

  MQTTManager(
      {required MQTTController state,
        required String host,
        required String topic,
        required String identifier})
      : _currentState = state,
        _host = host,
        _topic = topic,
        _identifier = identifier;

  void initializeMQTTClient() {
    _client = MqttServerClient(_host, _identifier);
    _client!.port = 1883;
    _client!.keepAlivePeriod = 20;
    _client!.onDisconnected = onDisconnected;
    _client!.secure = false;
    _client!.logging(on: true);

    _client!.onConnected = onConnected;
    _client!.onSubscribed = onSubscribed;

    final MqttConnectMessage connMess = MqttConnectMessage()
        .withClientIdentifier(_identifier)
        .withWillTopic('willtopic')
        .withWillMessage('My Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    debugPrint('client connecting....');
    _client!.connectionMessage = connMess;
  }

  void connect() async {
    assert(_client != null);
    try {
      _currentState.setAppConnectionState(MQTTConnectionState.connecting);
      await _client!.connect();
    } on Exception catch (e) {
      debugPrint('client exception - $e');
      disconnect();
    }
  }

  void onSubscribed(String topic) {
    debugPrint('Subscription confirmed for topic $topic');
  }

  void onDisconnected() {
    if (_client!.connectionStatus!.returnCode ==
        MqttConnectReturnCode.noneSpecified) {}
    _currentState.setAppConnectionState(MQTTConnectionState.disconnected);
  }

  void onConnected() {
    _currentState.setAppConnectionState(MQTTConnectionState.connected);
    debugPrint('client connected');
    _client!.subscribe(_topic, MqttQos.exactlyOnce);
    _client!.updates!.listen((List<MqttReceivedMessage> c) {
      final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
      final String pt =
      MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      _currentState.setReceivedText(pt);
      _currentState.handleReceivedMessage(pt);

    });
  }

  void disconnect() {
    _client!.disconnect();
  }

  void publish(String message) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);
    _client!.publishMessage(_topic, MqttQos.exactlyOnce, builder.payload!);
  }
}
