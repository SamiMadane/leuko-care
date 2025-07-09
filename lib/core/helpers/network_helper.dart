import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkHelper {
  static InternetConnection? _internetConnection;

  static set internetConnectionForTest(InternetConnection connection) {
    _internetConnection = connection;
  }

  static Stream<bool> get onStatusChange => (_internetConnection ?? InternetConnection()).onStatusChange
      .map((status) => status == InternetStatus.connected);
      
  static Future<bool> hasInternetConnection() async {
    return await (_internetConnection ?? InternetConnection()).hasInternetAccess;
  }
}
