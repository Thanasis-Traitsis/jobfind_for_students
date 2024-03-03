import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import './scaffold_message.dart';

class NetworkHelper {
  static void observeNetwork(
    GlobalKey<ScaffoldMessengerState> scaffoldKey,
    BuildContext context,
  ) {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        scaffoldKey.currentState?.showSnackBar(
          ScaffoldMessage(
            context: context,
            message: 'Δε βρέθηκε σύνδεση. Παρακαλώ συνδεθείτε στο διαδίκτυο.',
            noError: false,
            onTap: () {
              scaffoldKey.currentState?.hideCurrentSnackBar();
            },
          ),
        );
      } else {
        scaffoldKey.currentState?.hideCurrentSnackBar();
      }
    });
  }
}
