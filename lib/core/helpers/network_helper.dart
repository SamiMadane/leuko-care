import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkHelper {
  static Stream<bool> get onStatusChange => InternetConnection().onStatusChange
      .map((status) => status == InternetStatus.connected);
      
  static Future<bool> hasInternetConnection() async {
    return await InternetConnection().hasInternetAccess;
  }
}
