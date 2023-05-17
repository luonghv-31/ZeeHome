import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:zeehome/model/houses/house.dart';
import 'package:zeehome/network/house/create_house_request.dart';
import 'package:zeehome/network/uploadFile_request.dart';
import 'package:zeehome/screens/houseDetail/houseDetailScreen.dart';
import 'package:zeehome/utils/constants.dart';

class HouseExtraInfo extends StatefulWidget {
  final String access_token;
  Function (double price, double square, bool ac, bool parking, bool elevator, bool pet, int rooms, int bathRooms, int bedRooms, double maintenanceFee, bool furnished, String? thumbnail, List<String>? images, String? video ) setExtraHouseInfo;
  House Function () getHouseInfo;

  HouseExtraInfo({Key? key, required this.access_token, required this.setExtraHouseInfo, required this.getHouseInfo}) : super(key: key);

  @override
  State<HouseExtraInfo> createState() => _HouseExtraInfoState();
}

class _HouseExtraInfoState extends State<HouseExtraInfo> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController price = TextEditingController();
  TextEditingController square = TextEditingController();
  TextEditingController bedRooms = TextEditingController();
  TextEditingController bathRooms = TextEditingController();
  TextEditingController rooms = TextEditingController();
  TextEditingController maintanceFee = TextEditingController();
  bool ac = false;
  bool parking = false;
  bool elevator = false;
  bool pet = false;
  bool furnished = false;
  String? thumbnail;
  String? video;
  String? images;
  final double CardRadius = 10;

  final MaterialStateProperty<Icon?> thumbIcon =
  MaterialStateProperty.resolveWith<Icon?>(
        (Set<MaterialState> states) {
      // Thumb icon when the switch is selected.
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    elevation: 0,
    minimumSize: const Size(100, 36),
    maximumSize: const Size(200, 36),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4.0),
    ),
    backgroundColor: const Color.fromARGB(255, 38, 38, 115),
  );

  void myValueSetter(int progress) {
    EasyLoading.showProgress((progress / 100), status: 'Đang tải ảnh lên: $progress%');
  }

  Path defineCustomPath (size) {
    return Path()
      ..moveTo(CardRadius, 0)
      ..lineTo(size.width - CardRadius, 0)
      ..arcToPoint(Offset(size.width, CardRadius), radius: Radius.circular(CardRadius))
      ..lineTo(size.width, size.height - CardRadius)
      ..arcToPoint(Offset(size.width - CardRadius, size.height), radius: Radius.circular(CardRadius))
      ..lineTo(CardRadius, size.height)
      ..arcToPoint(Offset(0, size.height - CardRadius), radius: Radius.circular(CardRadius))
      ..lineTo(0, CardRadius)
      ..arcToPoint(Offset(CardRadius, 0), radius: Radius.circular(CardRadius));
  }

  void setThumbnail(String imageKey) {
    EasyLoading.dismiss();
    setState(() {
      thumbnail = imageKey;
    });
  }

  void setImages(String imageKey) {
    EasyLoading.dismiss();
    setState(() {
      images = imageKey;
    });
  }

  void setVideo(String imageKey) {
    EasyLoading.dismiss();
    setState(() {
      video = imageKey;
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
              const Text('Thông tin chi tiết', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black)),
              const SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Giá (vnd): ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  TextFormField(
                    controller: price,
                    keyboardType: TextInputType.number,
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
              const SizedBox(height: 12,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Diện tích (m2): ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  TextFormField(
                    controller: square,
                    keyboardType: TextInputType.number,
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
              const SizedBox(height: 12,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Điều hòa: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  Switch(
                    thumbIcon: thumbIcon,
                    value: ac,
                    onChanged: (bool value) {
                    setState(() {
                      ac = value;
                    });
                  },)
                ],
              ),
              const SizedBox(height: 12,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Chỗ đỗ xe: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  Switch(
                    thumbIcon: thumbIcon,
                    value: parking,
                    onChanged: (bool value) {
                      setState(() {
                        parking = value;
                      });
                    },)
                ],
              ),
              const SizedBox(height: 12,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Thang máy: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  Switch(
                    thumbIcon: thumbIcon,
                    value: elevator,
                    onChanged: (bool value) {
                      setState(() {
                        elevator = value;
                      });
                    },)
                ],
              ),
              const SizedBox(height: 12,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Thú cưng: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  Switch(
                    thumbIcon: thumbIcon,
                    value: pet,
                    onChanged: (bool value) {
                      setState(() {
                        pet = value;
                      });
                    },)
                ],
              ),
              const SizedBox(height: 12,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Phòng (sl): ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  TextFormField(
                    controller: rooms,
                    keyboardType: TextInputType.number,
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
              const SizedBox(height: 12,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Phòng tắm (sl): ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  TextFormField(
                    controller: bathRooms,
                    keyboardType: TextInputType.number,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Phòng ngủ (sl): ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  TextFormField(
                    controller: bedRooms,
                    keyboardType: TextInputType.number,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Phí duy trì (vnd): ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  TextFormField(
                    controller: maintanceFee,
                    keyboardType: TextInputType.number,
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
              const SizedBox(height: 12,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Thumbnail: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 6,),
                  DottedBorder(
                    padding: const EdgeInsets.only(top:16, bottom: 16, left: 20, right: 20),
                    color: Colors.black26,
                    strokeWidth: 3,
                    radius: Radius.circular(CardRadius),
                    dashPattern: [10, 5],
                    customPath: defineCustomPath,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: thumbnail != null ? Image.network(thumbnail!) : null,
                        ),
                        const SizedBox(height: 6,),
                        ElevatedButton(
                          onPressed: () async {
                            var picked = await FilePicker.platform.pickFiles(
                                withReadStream: true
                            );
                            if (picked != null) {
                              UploadFileRequest.fetchUploadFile(widget.access_token, 'image', picked.files.first, myValueSetter, setThumbnail).then((value) => {
                              });
                            }
                          },
                          style: elevatedButtonStyle,
                          child: Container(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: const Text('Tải ảnh lên', style: TextStyle(color: Colors.white)),
                          ),
                        )
                      ],
                    ),
                  ),

                ],
              ),

              const SizedBox(height: 12,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Ảnh: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 6,),
                  DottedBorder(
                    padding: const EdgeInsets.only(top:16, bottom: 16, left: 20, right: 20),
                    color: Colors.black26,
                    strokeWidth: 3,
                    radius: Radius.circular(CardRadius),
                    dashPattern: [10, 5],
                    customPath: defineCustomPath,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: images != null ? Image.network(images!) : null,
                        ),
                        const SizedBox(height: 6,),
                        ElevatedButton(
                          onPressed: () async {
                            var picked = await FilePicker.platform.pickFiles(
                                withReadStream: true
                            );

                            if (picked != null) {
                              UploadFileRequest.fetchUploadFile(widget.access_token, 'image', picked.files.first, myValueSetter, setImages).then((value) => {
                              });
                            }
                          },
                          style: elevatedButtonStyle,
                          child: Container(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: const Text('Tải ảnh lên', style: TextStyle(color: Colors.white)),
                          ),
                        )
                      ],
                    ),
                  ),

                ],
              ),

              const SizedBox(height: 12,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Video: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 6,),
                  DottedBorder(
                    padding: const EdgeInsets.only(top:16, bottom: 16, left: 20, right: 20),
                    color: Colors.black26,
                    strokeWidth: 3,
                    radius: Radius.circular(CardRadius),
                    dashPattern: [10, 5],
                    customPath: defineCustomPath,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: video != null ? Image.network(video!) : null,
                        ),
                        const SizedBox(height: 6,),
                        ElevatedButton(
                          onPressed: () async {
                            var picked = await FilePicker.platform.pickFiles(
                                withReadStream: true
                            );

                            if (picked != null) {
                              UploadFileRequest.fetchUploadFile(widget.access_token, 'video', picked.files.first, myValueSetter, setThumbnail).then((value) => {
                              });
                            }
                          },
                          style: elevatedButtonStyle,
                          child: Container(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: const Text('Tải video lên', style: TextStyle(color: Colors.white)),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Đang chờ xử lý')),
                    );
                    final List<String> imagesArray = images != null ? <String>[images.toString()] : <String>[];
                    widget.setExtraHouseInfo(double.parse(price.text), double.parse(square.text), ac, parking, elevator, pet, int.parse(rooms.text), int.parse(bathRooms.text), int.parse(bedRooms.text), double.parse(maintanceFee.text), furnished, thumbnail, imagesArray, video );
                    CreateHouseRequest.fetchCreateHouse(widget.access_token, widget.getHouseInfo()).then((value) => {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Tạo bài đăng thành công'),
                          content: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                SizedBox( height: 12 ),
                                Text('Giờ đây mọi người đã có thể xem bài đăng cùa bạn'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () =>  {
                                Navigator.of(context).push(scaleInTransition(HouseDetailScreen(houseDetail: widget.getHouseInfo()))),
                            },
                              child: const Text('Xác nhận'),
                            ),
                          ],
                        ),
                      )
                    });
                  }
                },
                child: const Text('Đăng bài', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
