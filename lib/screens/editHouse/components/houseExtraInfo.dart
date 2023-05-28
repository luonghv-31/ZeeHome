import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:zeehome/model/houseProvider.dart';
import 'package:zeehome/model/houses/house.dart';
import 'package:zeehome/network/house/edit_house_request.dart';
import 'package:zeehome/network/uploadFile_request1.dart';
import 'package:zeehome/screens/houseDetail/houseDetailScreen.dart';
import 'package:zeehome/utils/constants.dart';

class HouseExtraInfo extends StatefulWidget {
  final HouseProvider houseProvider;
  HouseExtraInfo({Key? key, required this.houseProvider }) : super(key: key);

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
  late VideoPlayerController _controller;


  @override
  void initState() {
    // TODO: implement initState
    House houseInfo = widget.houseProvider.getHouseInfor();
    debugPrint(houseInfo.images.toString());

    setState(() {
      price.text = houseInfo.price.toString();
      square.text = houseInfo.square.toString();
      bedRooms.text = houseInfo.bedRooms.toString();
      bathRooms.text = houseInfo.bathRooms.toString();
      rooms.text = houseInfo.rooms.toString();
      maintanceFee.text = houseInfo.maintenanceFee.toString();

      ac = houseInfo.ac!;
      parking = houseInfo.parking!;
      elevator = houseInfo.elevator!;
      pet = houseInfo.pet!;
      furnished = houseInfo.furnished!;
      // thumbnail = houseInfo.thumbnail == null ? null : houseInfo.thumbnail;
      // video = houseInfo.video == null ? null : houseInfo.video;
      // images = houseInfo.images != null ? houseInfo.images![0].toString() : null;
    });

    if (houseInfo.thumbnail != null) {
      setState(() {
        thumbnail = houseInfo.thumbnail;
      });
    }

    if (houseInfo.images != null) {
      setState(() {
        images = houseInfo.images![0].toString();
      });
    }

    if (houseInfo.video != null) {
      setState(() {
        video = houseInfo.video.toString();
      });

      _controller = VideoPlayerController.network(houseInfo!.video!);

      _controller.addListener(() {
        setState(() {});
      });
      _controller.setLooping(true);
      _controller.initialize().then((_) => setState(() {}));
      _controller.play();
    }

    super.initState();
  }

  @override
  void dispose() {
    if (_controller.value.isInitialized) {
      _controller.dispose();
    }
    super.dispose();
  }

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

 final ImagePicker _picker = ImagePicker();
 
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

  void handleUpdateHouse () {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đang chờ xử lý')),
      );
      final List<String> imagesArray = images != null ? <String>[images.toString()] : <String>[];
      widget.houseProvider.editExtraInfo(double.parse(price.text), double.parse(square.text), ac, parking, elevator, pet, int.parse(rooms.text), int.parse(bathRooms.text), int.parse(bedRooms.text), double.parse(maintanceFee.text), furnished, thumbnail, imagesArray, video );
      SharedPreferences.getInstance().then((prefs) {
        String access_token = prefs.get('access_token') as String;
        UpdateHouseRequest.fetchUpdateHouse(access_token, widget.houseProvider.getHouseInfor())
            .then((value) => {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Cập nhật bài đăng thành công.'),
              content: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    SizedBox( height: 12 ),
                    Text('Giờ đây mọi người đã có thể xem thay đổi bài đăng cùa bạn!'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () =>  {
                    Navigator.of(context).push(scaleInTransition(HouseDetailScreen(houseDetail: widget.houseProvider.getHouseInfor()))),
                  },
                  child: const Text('Xác nhận'),
                ),
              ],
            ),
          )
        }).catchError((err) {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Cảnh báo'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  SizedBox( height: 12 ),
                  Text('Tài khoản không đủ tiền để đăng bài!'),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () =>  {
                    Navigator.pop(context, 'Cancel'),
                    // Navigator.of(context).push(scaleInTransition(HouseDetailScreen(houseDetail: widget.getHouseInfo()))),
                  },
                  child: const Text('Xác nhận'),
                ),
              ],
            ),
          );
        });
      });
    }
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
              const SizedBox(height: 12,),
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
              const SizedBox(height: 12,),
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
                            final XFile? image = await _picker.pickImage(
                            source: ImageSource.gallery);
                            if (image != null) {
                              SharedPreferences.getInstance().then((prefs) {
                                String access_token = prefs.get('access_token') as String;
                                UploadFileRequest.fetchUploadFile(access_token, 'image', image, myValueSetter, setThumbnail);
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
                              SharedPreferences.getInstance().then((prefs) {
                                String access_token = prefs.get('access_token') as String;
                                UploadFileRequest.fetchUploadFile(access_token, 'image', picked.files.first, myValueSetter, setImages);
                              });
                            };
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
                          child: video != null ?  Container(
                            child: _controller.value.isInitialized
                            ? AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: VideoPlayer(_controller),
                            )
                            : Container(),
                          ) : null,
                        ),
                        const SizedBox(height: 6,),
                        ElevatedButton(
                          onPressed: () async {
                            var picked = await FilePicker.platform.pickFiles(
                                withReadStream: true
                            );

                            if (picked != null) {
                              SharedPreferences.getInstance().then((prefs) {
                                String access_token = prefs.get('access_token') as String;
                                UploadFileRequest.fetchUploadFile(access_token, 'image', picked.files.first, myValueSetter, setVideo);
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
                  handleUpdateHouse();
                },
                child: const Text('Cập nhật bài đăng', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
