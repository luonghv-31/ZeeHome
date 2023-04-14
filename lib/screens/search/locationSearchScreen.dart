import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zeehome/components/locationListTitle.dart';
import 'package:zeehome/model/autocomplete/placeAutoCompleteResponse.dart';
import 'package:zeehome/network/place_request.dart';
import 'package:zeehome/utils/constants.dart';
import 'package:zeehome/model/autocomplete/autoCompletePrediction.dart';
import 'dart:async';

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({Key? key}) : super(key: key);

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  List<AutocompletePrediction> placePredictions = [];

  Timer? _debounce;

  void placeAutocomplete(String query) async {

    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () async {
      Uri uri = Uri.https(
          "maps.googleapis.com",
          "maps/api/place/autocomplete/json",
          {
            "input": query,
            "key": apiKey,
          }
      );
      String? response = await PlaceRequest.fetchPlaces(uri);

      if (response != null) {
        PlaceAutocompleteResponse result = PlaceAutocompleteResponse.parseAutocompleteResult(response);
        if(result.predictions != null) {
          setState(() {
            placePredictions = result.predictions!;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Padding(
          padding: EdgeInsets.only(left: defaultPadding),
          child: CircleAvatar(
            backgroundColor: secondaryColor10LightTheme,
            child: Icon(
              Icons.near_me,
              color: secondaryColor40LightTheme,
              size: 24.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
          ),
        ),
        title: const Text(
          "Set Delivery Location",
          style: TextStyle(color: textColorLightTheme),
        ),
        actions: [
          CircleAvatar(
            backgroundColor: secondaryColor10LightTheme,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close, color: Colors.black),
            ),
          ),
          const SizedBox(width: defaultPadding)
        ],
      ),
      body: Column(
        children: [
          Form(
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: TextFormField(
                onChanged: (value) {
                  placeAutocomplete(value);
                },
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: "Search your location",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: SvgPicture.asset("assets/icon/location_pin.svg"),
                  ),
                ),
              ),
            ),
          ),
          const Divider(
            height: 2,
            thickness: 2,
            color: secondaryColor10LightTheme,
          ),
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: ElevatedButton.icon(
              onPressed: () {
              //  for testing let call the functon white press
                placeAutocomplete('dubai');
              },
              icon: const Icon(
                Icons.near_me,
                color: secondaryColor40LightTheme,
                size: 24.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
              label: const Text("Use my Current Location"),
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor10LightTheme,
                foregroundColor: textColorLightTheme,
                elevation: 0,
                fixedSize: const Size(double.infinity, 40),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),
          const Divider(
            height: 2,
            thickness: 2,
            color: secondaryColor10LightTheme,
          ),

          Expanded(
            child:  ListView.builder(
              itemCount: placePredictions.length,
              itemBuilder: (context, index) =>  LocationListTile(
                press: () {},
                location: placePredictions[index].description!,
              )
            ),
          )
        ],
      ),
    );
  }
}
