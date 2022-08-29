import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> checkConnectionn() async{

  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // I am connected to a mobile network.

    return false;

  } else{
    // I am connected to a wifi network.
    return true;

  }


}