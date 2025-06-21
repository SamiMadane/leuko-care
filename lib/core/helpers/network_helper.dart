import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkHelper {
  static Future<bool> hasInternetConnection() async {
    return await InternetConnection().hasInternetAccess;
  }
}
