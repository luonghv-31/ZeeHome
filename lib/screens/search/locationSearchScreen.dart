import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zeehome/components/locationListTitle.dart';
import 'package:zeehome/model/autocomplete/placeAutoCompleteResponse.dart';
import 'package:zeehome/network/map/place_request.dart';
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
  String? queryType;
  double? distance;
  String? queryFor;
  String? polygonPoints;
  String? mapPoint;
  bool? showInvisible;
  int? pageSize;
  int? pageNumber;
  String? houseType;
  String? roomGte;
  String? bedRoomGte;
  String? bathRoomGte;
  String? priceFrom;
  String? priceTo;
  bool hasAc = false;
  bool hasParking = false;
  bool hasElevator = false;
  bool hasFurnished = false;
  bool allowPet = false;
  String? houseCategory;

  List<Map<String, String>> priceOptions = [
    {
      'value': '1000000',
      'label': '1 triệu',
    },
    {
      'value': '5000000',
      'label': '5 triệu'
    },
    {
      'value': '10000000',
      'label': '10 triệu'
    },
    {
      'value': '50000000',
      'label': '50 triệu'
    },
    {
      'value': '100000000',
      'label': '100 triệu'
    },
    {
      'value': '1000000000',
      'label': '1 tỷ'
    }
  ];

  List<Map<String, String>> countOptions = [
    {
      'value': '1',
      'label': '1+',
    },
    {
      'value': '2',
      'label': '2+'
    },
    {
      'value': '3',
      'label': '3+'
    },
    {
      'value': '4',
      'label': '4+'
    },
    {
      'value': '5',
      'label': '5+'
    },
    {
      'value': '6',
      'label': '6+'
    },
    {
      'value': '7',
      'label': '7+'
    },
    {
      'value': '8',
      'label': '8+'
    }
  ];


  List<Map<String, String>> houseCategoryOptions = [
    {
      'value': '1',
      'label': 'Chung cư',
    },
    {
      'value': '2',
      'label': 'Nhà'
    },
    {
      'value': '3',
      'label': 'Đất'
    },
    {
      'value': '4',
      'label': 'Văn phòng cho thuê'
    },
    {
      'value': '5',
      'label': 'Nhà trọ'
    }
  ];

  List<Map<String, String>> houseTypeOptions = [
    {
      'value': '1',
      'label': 'Cho bán',
    },
    {
      'value': '2',
      'label': 'Cho thuê'
    },
  ];

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

  Widget buildFilter() {
    return Container(
      child: Column(
        children: [
          const Text('Bộ lọc', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w300)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Thể loại: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              DropdownButtonFormField(
                value: houseType,
                isExpanded: true,
                onChanged: (value) {
                  setState(() {
                    houseType = value;
                  });
                },
                onSaved: (value) {
                  setState(() {
                    houseType = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Điền đầy đủ thông tin";
                  } else {
                    return null;
                  }
                },
                items: houseTypeOptions
                    .map((e) {
                  return DropdownMenuItem(
                    value: e['value'],
                    child: Text(
                      e['label'].toString(),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 8,),
              const Text('Loại hình: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              DropdownButtonFormField(
                value: houseCategory,
                isExpanded: true,
                onChanged: (value) {
                  setState(() {
                    houseCategory = value;
                  });
                },
                onSaved: (value) {
                  setState(() {
                    houseCategory = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Điền đầy đủ thông tin";
                  } else {
                    return null;
                  }
                },
                items: houseCategoryOptions
                    .map((e) {
                  return DropdownMenuItem(
                    value: e['value'],
                    child: Text(
                      e['label'].toString(),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 8,),
              const Text('Giá thấp nhất: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              DropdownButtonFormField(
                value: priceFrom,
                isExpanded: true,
                onChanged: (value) {
                  setState(() {
                    priceFrom = value;
                  });
                },
                onSaved: (value) {
                  setState(() {
                    priceFrom = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Điền đầy đủ thông tin";
                  } else {
                    return null;
                  }
                },
                items: priceOptions
                    .map((e) {
                  return DropdownMenuItem(
                    value: e['value'],
                    child: Text(
                      e['label'].toString(),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 8,),
              const Text('Giá cao nhất: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              DropdownButtonFormField(
                value: priceTo,
                isExpanded: true,
                onChanged: (value) {
                  setState(() {
                    priceTo = value;
                  });
                },
                onSaved: (value) {
                  setState(() {
                    priceTo = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Điền đầy đủ thông tin";
                  } else {
                    return null;
                  }
                },
                items: priceOptions
                    .map((e) {
                  return DropdownMenuItem(
                    value: e['value'],
                    child: Text(
                      e['label'].toString(),
                    ),
                  );
                }).toList(),
              ),


              const SizedBox(height: 8,),
              const Text('Phòng tắm: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              DropdownButtonFormField(
                value: bathRoomGte,
                isExpanded: true,
                onChanged: (value) {
                  setState(() {
                    bathRoomGte = value;
                  });
                },
                onSaved: (value) {
                  setState(() {
                    bathRoomGte = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Điền đầy đủ thông tin";
                  } else {
                    return null;
                  }
                },
                items: countOptions
                    .map((e) {
                  return DropdownMenuItem(
                    value: e['value'],
                    child: Text(
                      e['label'].toString(),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 8,),
              const Text('Phòng ngủ: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              DropdownButtonFormField(
                value: bedRoomGte,
                isExpanded: true,
                onChanged: (value) {
                  setState(() {
                    bedRoomGte = value;
                  });
                },
                onSaved: (value) {
                  setState(() {
                    bedRoomGte = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Điền đầy đủ thông tin";
                  } else {
                    return null;
                  }
                },
                items: countOptions
                    .map((e) {
                  return DropdownMenuItem(
                    value: e['value'],
                    child: Text(
                      e['label'].toString(),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12,),
            ],
          ),
          const SizedBox(height: 12,),
          const Text('Tìm kiếm', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w300)),
          const SizedBox(height: 4,),
        ],
      ),
    );
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
          "Bộ lọc tìm kiếm",
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
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height + 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Form(
                  child: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Column(
                      children: [
                        buildFilter(),
                        TextFormField(
                          onChanged: (value) {
                            placeAutocomplete(value);
                          },
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            hintText: "Tìm kiếm địa điểm",
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: SvgPicture.asset("assets/icon/location_pin.svg"),
                            ),
                          ),
                        )
                      ],
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
                    label: const Text("Sử dụng vị trí của tôi"),
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
                  child: ListView.builder(
                    itemCount: placePredictions.length,
                    itemBuilder: (context, index) =>  LocationListTile(
                      press: () {},
                      location: placePredictions[index].description!,
                    )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
