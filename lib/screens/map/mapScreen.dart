import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zeehome/model/houses/parameter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  // final Completer<GoogleMapController> _controller = Completer();
  HouseListParameter houseListParameter = HouseListParameter(queryFor: 'map', queryType: 'distance', distance: null, polygonPoints: null, mapPoint: null, showInvisible: null, pageSize: 5, pageNumber: 0);

  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Track order"),
      ),
      body: const GoogleMap(initialCameraPosition: CameraPosition(target: sourceLocation, zoom: 14.5)),
    );
  }
}
