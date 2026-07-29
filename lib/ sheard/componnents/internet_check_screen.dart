import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hr_manegement/core/text_style.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

import '../../core/app_colors.dart';

class InternetCheckWidget extends StatefulWidget {
  final Widget child;

  const InternetCheckWidget({super.key, required this.child});

  @override
  State<InternetCheckWidget> createState() => _InternetCheckWidgetState();
}

class _InternetCheckWidgetState extends State<InternetCheckWidget> {
  late StreamSubscription _subscription;
  bool _isSnackbarVisible = false;
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _subscription = Connectivity().onConnectivityChanged.listen(
      _handleConnectionChange,
    );
    _checkInitialConnection();
  }

  Future<void> _checkInitialConnection() async {
    var result = await Connectivity().checkConnectivity();
    _handleConnectionChange(result);
  }

  void _handleConnectionChange(List<ConnectivityResult> result) {
    final isConnected =
        result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi) ||
        result.contains(ConnectivityResult.ethernet);

    if (!isConnected && !_isSnackbarVisible) {
      _showTopSnackbar();
    } else if (isConnected && _isSnackbarVisible) {
      _hideTopSnackbar();
    }
  }

  void _showTopSnackbar() {
    _isSnackbarVisible = true;

    final overlay = Overlay.of(context);
    // ignore: unnecessary_null_comparison
    if (overlay == null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: CustomSnackBar.error(
              message:
                  "${"No Internet Connection!".tr()}\n${"Please check your connection.".tr()}",
              backgroundColor: AppColors.primary,
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: const FaIcon(
                  FontAwesomeIcons.wifi,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              textStyle: AppTextStyle.body.copyWith(color: Colors.white),
              messagePadding: EdgeInsets.all(10),
            ),
          ),
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  void _hideTopSnackbar() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _isSnackbarVisible = false;
  }

  @override
  void dispose() {
    _subscription.cancel();
    _hideTopSnackbar();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
