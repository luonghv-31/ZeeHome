import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zeehome/model/houseProvider.dart';
import 'package:zeehome/screens/createHouse/extraInfoScreen.dart';
import 'package:zeehome/utils/constants.dart';

class HousePositionScreen extends StatefulWidget {
  HousePositionScreen({Key? key}) : super(key: key);
  @override
  State<HousePositionScreen> createState() => _HousePositionScreenState();
}

class _HousePositionScreenState extends State<HousePositionScreen> {
  static const LatLng sourceLocation = LatLng(21.028511, 105.804817);
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  @override
  Widget build(BuildContext context) {
    return Consumer<HouseProvider>(builder: (context, houseProvider ,child){
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.only(left: defaultPadding),
            child: CircleAvatar(
              backgroundColor: secondaryColor10LightTheme,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.undo,
                  color: secondaryColor40LightTheme,
                  size: 24.0,
                  semanticLabel: 'Text to announce in accessibility modes',
                )
              ),
            ),
          ),
          title: const Text(
            "Lựa chọn vị trí",
            style: TextStyle(color: textColorLightTheme),
          ),
          actions: [
            CircleAvatar(
              backgroundColor: secondaryColor10LightTheme,
              child: IconButton(
                onPressed: () {
                  if (markers.isEmpty) {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Cảnh báo!'),
                        content: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              SizedBox( height: 12 ),
                              Text('Vui lòng chọn 1 vị trí trên bản đồ trước khi tiếp tục: '),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Xác nhận'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    debugPrint('this is next ${markers.values.first.position}');
                    houseProvider.setPosition(markers.values.first.position.latitude, markers.values.first.position.longitude, 'this is address');
                    Navigator.of(context).push(scaleInTransition(const ExtraInfoScreen()));
                  }
                },
                icon: const Icon(Icons.arrow_forward, color: Colors.black),
              ),
            ),
            const SizedBox(width: defaultPadding)
          ],
        ),
        body: GoogleMap(
          onTap: (LatLng latLng) {
            setState(() {
              final Marker marker = Marker(
                markerId: const MarkerId('marker'),
                position: latLng,
                infoWindow: const InfoWindow(title: 'this', snippet: '*'),
              );
              setState(() {
                markers[const MarkerId('marker')] = marker;
              });
            });
          },
          initialCameraPosition: const CameraPosition(
              target: sourceLocation,
              zoom: 14.5
          ),
          markers: Set<Marker>.of(markers.values),
        ),
      );
    });
  }
}

