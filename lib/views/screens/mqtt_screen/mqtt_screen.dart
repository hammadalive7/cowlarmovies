import 'package:cowlarmovies/services/mqtt_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        title: const Text('MQTT', style: TextStyle(color: Colors.white, fontSize: 16)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [







              ],
            ),
          ),
        ),
      )
    );
  }
}
