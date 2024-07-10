import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import '../../../controllers/bluetooth_controller.dart';

class BluetoothScreen extends StatelessWidget {
  BluetoothScreen({super.key});

  final controller = Get.find<BluetoothController>();

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
          child: SizedBox(
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
                Obx(() {
                  final isConnected =
                      controller.adapterState.value == BluetoothAdapterState.on;
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      color: isConnected ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        isConnected ? 'Connected' : 'Disconnected',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                }),
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
                Obx(() {
                  final pairedDevices = controller.pairedDevices;
                  if (pairedDevices.isEmpty) {
                    return const Center(
                      child: Text(
                        'No paired devices',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: pairedDevices.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(
                          Icons.devices,
                          color: Colors.white,
                        ),
                        title: Text(
                          pairedDevices[index].name,
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          pairedDevices[index].id.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
