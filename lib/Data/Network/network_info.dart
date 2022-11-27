import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class networkInfo {
  Future<bool> isConnected();
}

class networkInfoImpl implements networkInfo {
  InternetConnectionChecker _internetConnectionChecker;
  networkInfoImpl(this._internetConnectionChecker);
  @override
  Future<bool> isConnected() {
    return _internetConnectionChecker.hasConnection;
  }
}
