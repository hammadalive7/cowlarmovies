import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothController extends GetxController {
  var adapterState = BluetoothAdapterState.unknown.obs;
  var pairedDevices = <BluetoothDevice>[].obs;

  late StreamSubscription<BluetoothAdapterState> _adapterStateSubscription;

  @override
  void onInit() {
    super.onInit();
    _adapterStateSubscription = FlutterBluePlus.adapterState.listen((state) {
      adapterState.value = state;
      if (state == BluetoothAdapterState.on) {
        _requestPermissions().then((granted) {
          if (granted) {
            _fetchPairedDevices();
          } else {
            Get.snackbar("Error", "Permissions not granted");
            print("Permissions not granted");
          }
        });
      }
    });
  }

  Future<bool> _requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.location
    ].request();

    return statuses.values.every((status) => status.isGranted);
  }

  Future<void> _fetchPairedDevices() async {
    try {
      List<BluetoothDevice> devices = await FlutterBluePlus.bondedDevices;
      pairedDevices.value = devices;
    } catch (e) {
      print("Error fetching paired devices: $e");
    }
  }

  @override
  void onClose() {
    _adapterStateSubscription.cancel();
    super.onClose();
  }
}
