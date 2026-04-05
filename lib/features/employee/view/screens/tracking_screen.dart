import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

import 'package:hr_manegement/core/app_colors.dart';

import '../../../../ sheard/componnents/icon_button.dart';
import '../widgets/map_icon.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  GoogleMapController? _mapController;

  LatLng? _currentLatLng;
  BitmapDescriptor? _customMarker;

  String? employeeName;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (employeeName == null) {
      employeeName =
      ModalRoute.of(context)!.settings.arguments as String?;
      _init();
    }
  }

  Future<void> _init() async {
    await _handleLocationPermission();

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    _currentLatLng = LatLng(position.latitude, position.longitude);

    _customMarker = await MapIcon(
      name: employeeName ?? "Employee",
      image: "assets/images/avatar1.png",
      onTap: () {
        debugPrint("Marker tapped");
      },
    ).toBitmapDescriptor();

    setState(() {});
  }

  Future<void> _handleLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }
  }

  Future<void> _goToMyLocation() async {
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final latLng = LatLng(position.latitude, position.longitude);

    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_currentLatLng == null || _customMarker == null) {
      return Scaffold(
        backgroundColor: AppColors.backGround,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.backGround,
      body: Stack(
        children: [
          /// 🔹 MAP
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _currentLatLng!,
              zoom: 16,
            ),
            markers: {
              Marker(
                markerId: const MarkerId("employee"),
                position: _currentLatLng!,
                icon: _customMarker!,
                infoWindow: InfoWindow(
                  title: employeeName ?? "Employee",
                ),
              ),
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            onMapCreated: (controller) {
              _mapController = controller;
            },
          ),

          /// 🔹 GPS BUTTON
          Positioned(
            bottom: 200,
            left: 16,
            child: GestureDetector(
              onTap: _goToMyLocation,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withOpacity(0.8),
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.my_location,
                  size: 20,
                  color: AppColors.white,
                ),
              ),
            ),
          ),

          /// 🔹 EMPLOYEE CARD
          PositionedDirectional(
            bottom: 40,
            start: 16,
            end: 16,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowColor,
                    blurRadius: 12,
                  ),
                ],
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 22,
                    backgroundImage:
                    AssetImage("assets/images/avatar1.png"),
                  ),
                  const SizedBox(width: 10),

                  /// NAME
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          employeeName ?? "Employee",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: AppColors.textMain,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Tracking Active",
                          style: TextStyle(
                            color: AppColors.textSub,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// STATUS
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: AppColors.green,
                          size: 8,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "Active",
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.textMain,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

          /// 🔹 BACK BUTTON
          PositionedDirectional(
            top: 50,
            start: 10,
            child: AppIcon(
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}