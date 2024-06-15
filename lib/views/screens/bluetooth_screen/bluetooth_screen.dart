import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import '../../../controllers/bluetooth_controller.dart';

class BluetoothScreen extends StatelessWidget {
  BluetoothScreen({super.key});

  final controller = Get.put(BluetoothController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Bluetooth',
              style: TextStyle(color: Colors.white, fontSize: 16)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Status',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.005,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      color: controller.adapterState.value ==
                              BluetoothAdapterState.on
                          ? Colors.green
                          : Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Obx(() {
                      if (controller.adapterState.value ==
                          BluetoothAdapterState.on) {
                        return const Center(
                          child: Text(
                            'Connected',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                      } else {
                        controller.pairedDevices.clear();
                        return const Center(
                          child: Text(
                            'Disconnected',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }
                    }),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  const Text(
                    'Paired Devices',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.005,
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.005,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.pairedDevices.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(
                          Icons.devices,
                          color: Colors.white,
                        ),
                        title: Text(
                          controller.pairedDevices[index].name,
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          controller.pairedDevices[index].id.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
