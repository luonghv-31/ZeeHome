import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zeehome/model/houses/house.dart';
import 'package:zeehome/model/houses/parameter.dart';
import 'package:zeehome/network/house/house_detail_request.dart';
import 'package:zeehome/network/house/house_list_request.dart';
import 'package:zeehome/screens/houseDetail/houseDetailScreen.dart';
import 'package:zeehome/utils/constants.dart';

class MapScreen extends StatefulWidget {
  final LatLng latlng;
  final  HouseListParameter houseListParameter;
  const MapScreen({Key? key, required this.houseListParameter, required this.latlng}) : super(key: key);

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  // final Completer<GoogleMapController> _controller = Completer();
  // HouseListParameter houseListParameter = HouseListParameter(queryFor: 'map', queryType: 'distance', distance: 10, polygonPoints: null, mapPoint: '105.804817,21.028511', showInvisible: false, pageSize: 5, pageNumber: 0);
  List<House> houseList = [];
  List<Marker> _markers = <Marker>[];

  static const LatLng destination = LatLng(21.028511, 105.804817);

  @override
  void initState() {
    // TODO: implement initState
    List<Marker> marker = <Marker>[];
    HouseListRequest.fetchHouseList(widget.houseListParameter).then((value) => {
      value.forEach((item) {
        if (item.houseId != null && item.latitude != null  && item.longitude != null) {
          marker.add(
            Marker(
              markerId: MarkerId(item.houseId.toString()),
              position: LatLng(item.latitude!, item.longitude!),
              infoWindow: InfoWindow(
                title: '${item.price} vnd'
              ),
              onTap: () {
                GetHouseDetailRequest.fetchHouseDetail(item.houseId!).then((value) => {
                  Navigator.of(context).push(scaleInTransition(HouseDetailScreen(houseDetail: value,))),
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
        initialCameraPosition: CameraPosition(
          target: widget.latlng,
          zoom: 14.5
        ),
        markers: Set<Marker>.of(_markers),
      ),
    );
  }
}
