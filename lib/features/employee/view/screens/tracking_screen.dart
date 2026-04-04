import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hr_manegement/%20sheard/componnents/icon_button.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

import '../widgets/map_icon.dart';

/// 🔹 IMPORT YOUR MAP ICON

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  GoogleMapController? _mapController;

  LatLng? _currentLatLng;
  BitmapDescriptor? _customMarker;

  @override
  void initState() {
    super.initState();
    _init();
  }

  /// 🔹 Initialize location + marker
  Future<void> _init() async {
    await _handleLocationPermission();

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    _currentLatLng = LatLng(position.latitude, position.longitude);

    /// 🔹 Create custom marker using your widget
    _customMarker = await MapIcon(
      name: "Abdelrahman",
      image: "assets/images/avatar1.png",
      onTap: () {
        debugPrint("Marker tapped");
      },
    ).toBitmapDescriptor();

    setState(() {});
  }

  /// 🔹 Handle permissions
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

  /// 🔹 Move camera to current location
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
    /// 🔹 Loading state
    if (_currentLatLng == null || _customMarker == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          /// 🔹 GOOGLE MAP
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _currentLatLng!,
              zoom: 16,
            ),
            markers: {
              Marker(
                markerId: const MarkerId("driver_marker"),
                position: _currentLatLng!,
                icon: _customMarker!,
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
            left: 12,
            child: GestureDetector(
              onTap: _goToMyLocation,
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 5),
                  ],
                ),
                child: const Icon(Icons.my_location),
              ),
            ),
          ),

          /// 🔹 TOP RIGHT INFO CARD
          PositionedDirectional(
            top: 50,
            end: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tracking in progress",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Driver Name",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),

          /// 🔹 BACK BUTTON
          PositionedDirectional(
            top: 50,
            start: 10,
            child: AppIcon(
              onTap: (){
                Navigator.pop(context);
              },
            )
          ),
        ],
      ),
    );
  }
}