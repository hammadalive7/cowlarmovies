import 'package:cowlarmovies/services/mqtt_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/mqtt_states.dart';
import '../../../controllers/mqtt_controller.dart';

class MQTTScreen extends StatefulWidget {
  const MQTTScreen({super.key});

  @override
  State<MQTTScreen> createState() => _MQTTScreenState();
}

class _MQTTScreenState extends State<MQTTScreen> {
  final TextEditingController _messageTextController = TextEditingController();
  final TextEditingController _topicTextController = TextEditingController();
  late MQTTController controller;
  late MQTTManager manager;
  String host = 'test.mosquitto.org';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _messageTextController.dispose();
    _topicTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller = Get.put(MQTTController());

    return Scaffold(
        appBar: AppBar(
          title: const Text('MQTT',
              style: TextStyle(color: Colors.white, fontSize: 16)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          controller: _topicTextController,
                          decoration: const InputDecoration(
                              prefixStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              labelStyle: TextStyle(color: Colors.white),
                              fillColor: Colors.white,
                              labelText: 'Topic'),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.grey[300],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              if (controller.getAppConnectionState ==
                                  MQTTConnectionState.connected) {
                                _disconnect();
                                Get.snackbar('Success', 'MQTT disconnected');
                              } else if (controller.getAppConnectionState ==
                                  MQTTConnectionState.disconnected) {
                                if (_topicTextController.text.isNotEmpty) {
                                  _configureAndConnect();
                                  Get.snackbar('Success', 'MQTT connected');
                                } else {
                                  Get.snackbar('Error', 'Please enter a topic');
                                }
                              }
                            },
                            child: controller.getAppConnectionState ==
                                    MQTTConnectionState.disconnected
                                ? const Text('Connect',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16))
                                : const Text('Disconnect',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16))),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          controller: _messageTextController,
                          decoration: const InputDecoration(
                              prefixStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              labelStyle: TextStyle(color: Colors.white),
                              fillColor: Colors.white,
                              labelText: 'Message'),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.grey[300],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              if (controller.getAppConnectionState ==
                                      MQTTConnectionState.connected &&
                                  _messageTextController.text.isNotEmpty) {
                                _publishMessage(_messageTextController.text);
                              } else {
                                if (controller.getAppConnectionState !=
                                    MQTTConnectionState.connected) {
                                  Get.snackbar(
                                      'Error', 'Not Connected to MQTT Server');
                                } else {
                                  Get.snackbar(
                                      'Error', 'Message cannot be empty');
                                }
                              }
                            },
                            child: const Text('Send',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16))),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Published Message:",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Divider(
                              thickness: 1,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              controller.getHistoryText,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ));
  }

  void _configureAndConnect() {
    // ignore: flutter_style_todos
    // TODO: Use UUID
    String osPrefix = 'hammadalive';

    manager = MQTTManager(
        host: host,
        topic: _topicTextController.text,
        identifier: osPrefix,
        state: controller);
    manager.initializeMQTTClient();
    manager.connect();
  }

  void _disconnect() {
    manager.disconnect();
  }

  void _publishMessage(String text) {
    String osPrefix = 'hammadalive';

    final String message = osPrefix + ': ' + text;
    manager.publish(message);
    _messageTextController.clear();
  }
}
