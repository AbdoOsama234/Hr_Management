import 'dart:async';
import 'dart:developer';
import 'package:hr_manegement/core/constants.dart';
import 'package:hr_manegement/core/di/di.dart';
import 'package:hr_manegement/core/storage/local/app_prefs.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mp;

import '../../app_colors.dart';
import '../../text_style.dart';

enum LocationPermissionStatus { disabled, denied, permanentlyDenied }

class LocationHelper {
  final BuildContext context;

  LocationHelper(this.context);
  static Future<Position> _getMyPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    log(serviceEnabled.toString());
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error(LocationPermissionStatus.disabled);
    }
    //Permission.location.request();
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.

        return Future.error(LocationPermissionStatus.denied);
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(LocationPermissionStatus.permanentlyDenied);
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  static Future<Position?> determinePosition() async {
    try {
      Position position = await _getMyPosition();
      log("latitude is ${position.latitude}");
      log("longitude is ${position.longitude}");
      return position;
    } catch (e) {
      if (e == LocationPermissionStatus.disabled) {
        log('Location services are disabled.');
        await showPermissionsDeniedDialog('location_services_are_disabled'.tr);
      } else if (e == LocationPermissionStatus.denied) {
        log('Location permissions are denied');
        await showPermissionsDeniedDialog('location_permissions_are_denied'.tr);
      } else if (e == LocationPermissionStatus.permanentlyDenied) {
        log('Location permissions are permanently denied');
        await showPermissionsDeniedDialog(
          'location_permissions_are_permanently_denied'.tr,
        );
      } else {
        log('Location Erorr: ${e.toString()}');
      }
      return null;
    }
  }

  static Future<void> showPermissionsDeniedDialog(String title) async {
    await Get.defaultDialog(
      contentPadding: const EdgeInsets.all(8),
      backgroundColor: AppColors.white,
      radius: 5,
      title: 'location_permissions'.tr,
      titleStyle: AppTextStyle.headline,
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: AppTextStyle.headline,
      ),
      actions: [
        TextButton(
          onPressed: () async {
            var value = await Geolocator.openLocationSettings();
            log("value is ${value.toString()}");
            Get.back();
          },
          child: Text('go_to_setting', style: AppTextStyle.headline),
        ),
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('cancel', style: AppTextStyle.headline),
        ),
      ],
    );
  }

  static Future<String?> getLocationName(LatLng position) async {
    try {
      print(getIt<AppPreferences>().lang);
      await setLocaleIdentifier(
        getIt<AppPreferences>().lang == Constants.arLanguage ? "ar" : "en",
      ); //here
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      String name1 = placemarks[0].name ?? '';
      String name2 = placemarks[0].administrativeArea ?? '';
      String name3 = placemarks[0].locality ?? '';
      String name4 = placemarks[0].subAdministrativeArea ?? '';
      String? name = '$name1 $name3 $name4 $name2';
      return name;
    } catch (e) {
      log("e is $e");
      return null;
    }
  }

  static bool isPointInPolygen(LatLng point, List<LatLng> points) {
    var convertedPoints = points
        .map((e) => mp.LatLng(e.latitude, e.longitude))
        .toList();
    return mp.PolygonUtil.containsLocation(
      mp.LatLng(point.latitude, point.longitude),
      convertedPoints,
      false,
    );
  }

  late Stream<Position?> positionStream;
  StreamSubscription<Position?>? streamSubscription;
  Stream<Position?> getPosition() async* {
    try {
      while (true) {
        Position? position = await determinePosition();
        yield position;
        await Future.delayed(const Duration(seconds: 100));
      }
    } catch (e) {
      log("Erorr getPosition $e");
    }
  }

  void startStream() {
    try {
      positionStream = getPosition();
      streamSubscription = positionStream.listen((event) async {
        if (event != null) {
          // Fluttertoast.showToast(
          //   msg: 'lat is ${event.latitude} lon is ${event.longitude}',
          //   backgroundColor: chooseToastColor(ToastStates.success),
          // );
          log("lat is ${event.latitude} lon is ${event.longitude}");
          //TODO: send position to back end
          //sendPositionToBackEnd(event);
        }
      }, cancelOnError: true);
    } catch (e) {
      log("Erorr startStream $e");
    }
  }

  Future<bool> checkIfWithinBounds(Position position) async {
    try {
      //GoogleMapController mapController=GoogleMapController.init(id, initialCameraPosition, googleMapState);
      //var mapBounds = await latLngBounds.getVisibleRegion();
      LatLngBounds latLngBounds = LatLngBounds(
        northeast: LatLng(position.latitude + 10, position.longitude + 10),
        southwest: LatLng(position.latitude - 10, position.longitude - 10),
      );

      return latLngBounds.contains(
        LatLng(position.latitude, position.longitude),
      );
    } catch (e) {
      log("Erorr send Position To Back End $e");
      return false;
    }
  }
}
