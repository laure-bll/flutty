import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DataMaps extends StatefulWidget {
  final Position coordonnees;
  const DataMaps({required this.coordonnees, super.key});

  @override
  State<DataMaps> createState() => _DataMapsState();
}

class _DataMapsState extends State<DataMaps> {
  Completer<GoogleMapController> completer = Completer();
  late CameraPosition camera;

  @override
  void initState() {
    camera = CameraPosition(
        target:
            LatLng(widget.coordonnees.latitude, widget.coordonnees.longitude),
        zoom: 14);
    super.initState();
  }

  Set<Marker> markers = {
    const Marker(markerId: MarkerId("sydney"), position: LatLng(-33.86, 151.20))
  };

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      markers: markers,
      initialCameraPosition: camera,
      onMapCreated: (mapsController) async {
        String customStyle = await DefaultAssetBundle.of(context)
            .loadString("lib/CustomMap.json");
        mapsController.setMapStyle(customStyle);
        completer.complete(mapsController);
      },
    );
  }
}
