import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

@Injectable(as: NetworkInfo)
class NetworkInfoImpl implements NetworkInfo {
  // ignore: unused_field
  final InternetConnectionChecker _internetConnectionChecker;

  NetworkInfoImpl(this._internetConnectionChecker);

  // @override
  // Future<bool> get isConnected => _internetConnectionChecker.hasConnection;
  @override
  Future<bool> get isConnected => Future.value(true);
}
