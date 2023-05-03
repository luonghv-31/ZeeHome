import 'package:flutter/material.dart';
import 'package:zeehome/model/country/provinceList.dart';
import 'package:zeehome/model/country/wardList.dart';
import 'package:zeehome/model/houses/house.dart';
import 'package:zeehome/model/user.dart';
import 'package:zeehome/network/country/country_request.dart';
import 'package:zeehome/network/country/district_request.dart';
import 'package:zeehome/network/country/ward_request.dart';
import 'package:zeehome/screens/createHouse/housePositionScreen.dart';
import 'package:zeehome/utils/constants.dart';

class HouseBasicInfor extends StatefulWidget {
  final String access_token;
  final User userInfo;
  Function(String title, String description, int houseType, int houseCategory, String province, String district, String ward, Owner owner) updateBasicInfo;

  HouseBasicInfor({Key? key, required this.access_token, required this.updateBasicInfo, required this.userInfo}) : super(key: key);

  @override
  State<HouseBasicInfor> createState() => _HouseBasicInforState();
}

class _HouseBasicInforState extends State<HouseBasicInfor> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  String? houseType = '1';
  String? houseCategory = '1';
  String? province;
  String? district;
  String? ward;
  TextEditingController description = TextEditingController();
  List<Province>? provinces;
  List<Province>? districts;
  List<Ward>? wards;

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

  @override
  void initState() {
    // TODO: implement initState
    GetListProvince.fetch().then((value) => {
     setState(() {
        provinces = value.provinces?.cast<Province>();
     })
    });
    super.initState();
  }

  void getDistrict(String id) {
    setState(() {
      district = null;
      ward = null;
    });
    GetListDistrict.fetch(widget.access_token.toString(), id).then((value) => {
      setState(() {
        districts = value.provinces?.cast<Province>();
      })
    });
  }

  void getListWard(String id) {
    setState(() {
      ward = null;
    });
    GetListWard.fetch(widget.access_token, id).then((value) => {
      setState(() {
        wards = value.ward?.cast<Ward>();
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.only(top: 16, left: 10, right: 10),
      padding: const EdgeInsets.only(top: 8, left: 12, right: 12, bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: DefaultTextStyle(
        style: const TextStyle(color: Color.fromARGB(255, 100, 100, 100), fontSize: 16),
        child: Form(
          key: _formKey,
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),
              const Text('Thông tin chung', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black)),
              const SizedBox(height: 24),
              const SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Tiêu đề: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  TextFormField(
                    controller: title,
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Điền đầy đủ thông tin';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Mô tả: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  TextFormField(
                    controller: description,
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Điền đầy đủ thông tin';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
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
                  )
                ],
              ),
              const SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  )
                ],
              ),
              const SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Tỉnh: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  DropdownButtonFormField(
                    value: province,
                    isExpanded: true,
                    onChanged: (value) {
                      getDistrict(value!);
                      setState(() {
                        province = value;
                      });
                    },
                    onSaved: (value) {
                      setState(() {
                        province = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Điền đầy đủ thông tin";
                      } else {
                        return null;
                      }
                    },
                    items: provinces
                        ?.map((e) {
                      return DropdownMenuItem(
                        value: e.code,
                        child: Text(
                          e.name.toString(),
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
              const SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Quận/Huyện: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  DropdownButtonFormField(
                    value: district,
                    isExpanded: true,
                    onChanged: (value) {
                      getListWard(value!);
                      setState(() {
                        district = value;
                      });
                    },
                    onSaved: (value) {
                      setState(() {
                        district = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Điền đầy đủ thông tin";
                      } else {
                        return null;
                      }
                    },
                    items: districts
                        ?.map((e) {
                      return DropdownMenuItem(
                        value: e.code,
                        child: Text(
                          e.name.toString(),
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
              const SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Xã/Phường: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  DropdownButtonFormField(
                    value: ward,
                    isExpanded: true,
                    onChanged: (value) {
                      setState(() {
                        ward = value;
                      });
                    },
                    onSaved: (value) {
                      setState(() {
                        ward = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Điền đầy đủ thông tin";
                      } else {
                        return null;
                      }
                    },
                    items: wards
                        ?.map((e) {
                      return DropdownMenuItem(
                        value: e.code,
                        child: Text(
                          e.name.toString(),
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final User user = widget.userInfo;
                    widget.updateBasicInfo(title.text, description.text, int.parse(houseType!), int.parse(houseCategory!), province!, district!, ward!, Owner(email: user.email, userId: user.userId, userImage: user.image,userRating: user.avgRating, lastName: user.lastName, firstName: user.firstName, phoneNumber: user.phoneNumber));
                    Navigator.of(context).push(scaleInTransition(HousePositionScreen()));
                  }
                },
                child: const Text('Tiếp tục', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
