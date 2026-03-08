import 'package:connectivity_plus/connectivity_plus.dart';

extension ConnectivityExtension on Connectivity{
  Future<bool>get isConnected async{
    List<ConnectivityResult> result =await checkConnectivity();
    return result.contains(ConnectivityResult.mobile)||result.contains(ConnectivityResult.wifi);

}
}