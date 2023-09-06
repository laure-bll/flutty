import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:untitled/view/DataMaps.dart';

import '../controller/PermissionGPS.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> completer = Completer();
  late CameraPosition camera;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Position>(
        future: PermissionGPS().init(),
        builder: (context, result) {
          if (result.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (result.data == null) {
            return const Center(
              child: Text("Oops, you don't have access to the map !"),
            );
          } else {
            Position coordonnees = result.data!;
            return DataMaps(coordonnees: coordonnees);
          }
        });
  }
}
