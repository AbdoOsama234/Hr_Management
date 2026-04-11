import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hr_manegement/core/constants.dart';

import '../../core/di/di.dart';
import '../../data/storage/local/app_prefs.dart';

class LocationHelper {
  LocationHelper._(); // private constructor

  /// ===============================
  /// Get full location name
  /// ===============================
  static Future<String> getLocationName(LatLng position) async {
    try {
      final lang = getIt<AppPreferences>().lang;
      log("lang in getLocationName is $lang");

      await setLocaleIdentifier(lang);

      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isEmpty) return "";

      final p = placemarks.first;

      return [
        p.name,
        p.locality,
        p.subAdministrativeArea,
        p.administrativeArea,
      ].where((e) => e != null && e.isNotEmpty).join(' ');
    } catch (e) {
      log("getLocationName error: $e");
      return "";
    }
  }

  /// ===============================
  /// Get city / area name
  /// ===============================
  static Future<String> getLocationCityName(LatLng position) async {
    try {
      final lang = getIt<AppPreferences>().lang.isEmpty
          ? Constants.defaultCurrency
          : getIt<AppPreferences>().lang;
      log("lang in getLocationCityName is $lang");

      await setLocaleIdentifier(lang);

      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isEmpty) return "";

      return "${placemarks.first.locality ?? ''} ${placemarks.first.subLocality ?? ''}"
          .trim();
    } catch (e) {
      log("getLocationCityName error: $e");
      return "";
    }
  }

  /// ===============================
  /// Convert address to LatLng
  /// ===============================
  static Future<LatLng> getLocationFromString(String address) async {
    try {
      final locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        return LatLng(locations.first.latitude, locations.first.longitude);
      }
    } catch (e) {
      log("getLocationFromString error: $e");
    }
    return const LatLng(0, 0);
  }

  /// ===============================
  /// ✅ Get my current location
  /// ===============================
  static Future<LatLng?> getMyLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        log("Location services are disabled");
        return null;
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          log("Location permission denied");
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        log("Location permission denied forever");
        return null;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      log("getMyLocation error: $e");
      return null;
    }
  }
}
