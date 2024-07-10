import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityManager{

  static isConnectedToInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult.first == ConnectivityResult.none ? false : true;
  }


}