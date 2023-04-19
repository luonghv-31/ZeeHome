import 'package:flutter/material.dart';
import 'package:zeehome/model/nearByPlace.dart';
import 'package:zeehome/network/near_by_request.dart';

class NearBySchoolComponent extends StatefulWidget {

  final String location;
  const NearBySchoolComponent({Key? key, required this.location}) : super(key: key);

  @override
  State<NearBySchoolComponent> createState() => _NearBySchoolComponentState();
}

class _NearBySchoolComponentState extends State<NearBySchoolComponent> {

  NearbyPlacesResponse nbrp = NearbyPlacesResponse();

  @override
  void initState() {
    // TODO: implement initState
    debugPrint(widget.location);
    GetNearByPlaceRequest.fetchNearBy( widget.location, 800, 'university').then((value) => {
      setState(() {
        nbrp = value;
      }),
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Trường học gần đây', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.black)),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: nbrp.results?.map((item) => Container(
              margin: EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 0, 107, 200),
                    radius: 20,
                    child: Text(item.rating != null ? '${item.rating}/5' : 'x/5', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: (
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.name.toString(), overflow: TextOverflow.ellipsis, maxLines: 1,
                              softWrap: false, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                            Text(item.vicinity.toString(), overflow: TextOverflow.ellipsis, maxLines: 1,
                                softWrap: false),
                          ],
                        )
                    ),
                  ),

                ],
              ),
            )).toList() ?? [],
          ),
        ],
      )
    );
 }
}
