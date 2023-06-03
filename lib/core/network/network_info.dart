import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';



abstract class NetworkInfo {
  Future<bool> get isConnected;
}

@LazySingleton(as: NetworkInfo)
class NetworkInfoImpl implements NetworkInfo {
  Future<bool> execute() async {
    final InternetConnectionChecker customInstance =
    InternetConnectionChecker.createInstance(
      checkTimeout: const Duration(seconds: 1),
      checkInterval: const Duration(seconds: 1),
    );
    // Simple check to see if we have Internet
    // ignore: avoid_debugPrint
    debugPrint('''The statement 'this machine is connected to the Internet' is: ''');
    bool isConnected = await customInstance.hasConnection;
    // ignore: avoid_debugPrint
    debugPrint(
      isConnected.toString(),
    );
    // returns a bool
    // We can also get an enum instead of a bool
    // ignore: avoid_debugPrint
    debugPrint(
      'Current status: ${await customInstance.connectionStatus}',
    );
    // debugPrints either InternetConnectionStatus.connected
    // or InternetConnectionStatus.disconnected

    // actively listen for status updates
    final StreamSubscription<InternetConnectionStatus> listener =
        customInstance.onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            // ignore: avoid_debugPrint
            debugPrint('Data connection is available.');
            isConnected = true;
            break;
          case InternetConnectionStatus.disconnected:
            // ignore: avoid_debugPrint
            debugPrint('You are disconnected from the internet.');
            isConnected = false;
            break;
        }
      },
    );

    // close listener after 30 seconds, so the program doesn't run forever
    await Future<void>.delayed(const Duration(seconds: 1));
    await listener.cancel();
    return isConnected;
  }

  @override
  Future<bool> get isConnected => execute();
}
