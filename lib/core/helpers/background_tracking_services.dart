import 'dart:developer';
import 'dart:ui';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hr_manegement/firebase_options.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

@pragma('vm:entry-point')
class BackgroundTrackingManager {
  static const String serviceId = "background_location_service";

  static Future<void> init() async {
    log("init FlutterBackgroundService tracking 1");
    final service = FlutterBackgroundService();

    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: _onStart,
        isForegroundMode: true,
        autoStart: false,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: false,
        onForeground: _onStart,
        onBackground: _onIosBackground,
      ),
    );

    log("init FlutterBackgroundService tracking 2");
  }

  static Future<bool> _requestPermissions() async {
    //await Permission.ignoreBatteryOptimizations.request();
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) return false;

    if (permission == LocationPermission.whileInUse) {
      permission = await Geolocator.requestPermission();
    }

    await Permission.notification.request();

    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  static Future<void> start() async {
    log("Start background tracking1");

    bool granted = await _requestPermissions();
    if (!granted) {
      log("Permissions not granted. Cannot start tracking.");
      return;
    }

    log("Start background tracking2");
    final service = FlutterBackgroundService();
    bool isRunning = await service.isRunning();
    if (!isRunning) {
      await service.startService();
    }
  }

  static Future<void> stop() async {
    final service = FlutterBackgroundService();
    service.invoke("stopService");
  }

  /// Main service entry point for both Android and iOS (foreground only)
  @pragma('vm:entry-point')
  static Future<void> _onStart(ServiceInstance service) async {
    log("_onStart new one background tracking1");
    DartPluginRegistrant.ensureInitialized();
    log("_onStart new one background tracking2");

    if (service is AndroidServiceInstance) {
      service.on("stopService").listen((event) {
        service.stopSelf();
      });
    }

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    log("_onStart new one background tracking5");

    // iOS cannot run while loop like Android — separate logic:
    if (service is AndroidServiceInstance) {
      // Android continuous loop
      while (await service.isForegroundService()) {
        await _updateLocation();
        await Future.delayed(const Duration(seconds: 20));
      }
    } else {
      // iOS foreground only — one-time update
      while (true) {
        await _updateLocation();
        await Future.delayed(const Duration(seconds: 20));
      }
    }

    log("_onStart new one background tracking DONE");
  }

  /// iOS background fetch handler
  @pragma('vm:entry-point')
  static Future<bool> _onIosBackground(ServiceInstance service) async {
    log("_onIosBackground background tracking START");
    try {
      DartPluginRegistrant.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      await _updateLocation();
      log("_onIosBackground background tracking END");
      return true;
    } catch (e) {
      log("iOS background fetch error: $e");
      return false;
    }
  }

  /// Get location and update Firebase
  static Future<void> _updateLocation() async {
    try {
      log("_updateLocation1");
      Position position = await Geolocator.getCurrentPosition();
      log("_updateLocation2");
      final prefs = await SharedPreferences.getInstance();
      final String userId = prefs.getString('user_id') ?? "0";
      log("Fetched userId: $userId");
      if (userId.isNotEmpty && userId != "0") {
        Map<String, dynamic> data = {
          "id": userId,
          "latitude": position.latitude.toString(),
          "longitude": position.longitude.toString(),
          "lastChange": DateTime.now().toIso8601String(),
        };
        final ref = FirebaseDatabase.instance.ref();
        await ref.child("users").child(userId).update(data);
        log("Updated location for user $userId");
      } else {
        log("User ID is empty");
      }
    } catch (e) {
      log("Background location error: $e");
    }
  }
}
