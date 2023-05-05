import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zeehome/model/houses/house.dart';
import 'package:zeehome/model/houses/houseList.dart';
import 'package:zeehome/model/houses/parameter.dart';
import 'package:zeehome/network/house/house_detail_request.dart';
import 'package:zeehome/network/house/house_list_request.dart';
import 'package:zeehome/screens/houseDetail/houseDetailScreen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => MapScreenState();
}

Route scaleIn(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, page) {
      var begin = 0.9;
      var end = 1.0;
      var curve = Curves.easeInOutBack;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      var tween2 = Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));


      return ScaleTransition(
        scale: animation.drive(tween),
        child: FadeTransition(
          opacity: animation.drive(tween2),
          child: page,
        ),
      );
    },
  );
}

class MapScreenState extends State<MapScreen> {
  // final Completer<GoogleMapController> _controller = Completer();
  HouseListParameter houseListParameter = HouseListParameter(queryFor: 'map', queryType: 'distance', distance: 10, polygonPoints: null, mapPoint: '105.804817,21.028511', showInvisible: false, pageSize: 5, pageNumber: 0);
  List<House> houseList = [];
  List<Marker> _markers = <Marker>[];

  static const LatLng sourceLocation = LatLng(21.028511, 105.804817);
  static const LatLng destination = LatLng(21.028511, 105.804817);

  @override
  void initState() {
    // TODO: implement initState
    List<Marker> marker = <Marker>[];
    HouseListRequest.fetchHouseList(houseListParameter).then((value) => {
      value.forEach((item) {
        if (item.houseId != null && item.latitude != null  && item.longitude != null) {
          marker.add(
            Marker(
              markerId: MarkerId(item.houseId.toString()),
              position: LatLng(item.latitude!, item.longitude!),
              infoWindow: const InfoWindow(
                title: 'The title of the marker'
              ),
              onTap: () {
                GetHouseDetailRequest.fetchHouseDetail(item.houseId!).then((value) => {
                  Navigator.of(context).push(scaleIn(HouseDetailScreen(houseDetail: value,))),
              });
              },
            )
          );
        }
      }),
      setState(() {
        houseList = value;
        _markers = marker;
      }),
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bản đồ"),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: sourceLocation,
          zoom: 14.5
        ),
        markers: Set<Marker>.of(_markers),
      ),
    );
  }
}
