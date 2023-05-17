import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeehome/model/user.dart';
import 'package:intl/intl.dart';
import 'package:zeehome/model/userProvider.dart';
import 'package:zeehome/network/uploadFile_request.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:zeehome/network/user/edit_user_request.dart';

class EditUserDetail extends StatefulWidget {
  final User user;
  final String access_token;
  final Size size;
  final f = DateFormat('dd-MM-yyyy');
  final inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ssZ");
  Function(String firstName, String lastName, String birthDate, String gender, String intro, String image, String phoneNumber) updateUser;
  EditUserDetail({Key? key, required this.user, required this.size, required this.access_token, required this.updateUser}) : super(key: key);

  @override
  State<EditUserDetail> createState() => _EditUserDetailState();
}

class _EditUserDetailState extends State<EditUserDetail> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController birthDate = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController image = TextEditingController();
  TextEditingController intro = TextEditingController();
  String? gender;
  final f = DateFormat('dd-MM-yyyy');
  final inputFormat = DateFormat("yyyy-MM-dd");

  List<Map<String, String>> genderList = [
    {
      'value': 'male',
      'label': 'Nam',
    },
    {
      'value': 'female',
      'label': 'Nữ'
    }
  ];

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      gender = widget.user.gender;
      firstName.text = widget.user.firstName;
      lastName.text = widget.user.lastName;
      birthDate.text = f.format(inputFormat.parse(widget.user.birthDate.toString()));
      phoneNumber.text = widget.user.phoneNumber;
      intro.text = widget.user.intro;
      image.text = widget.user.image;
    });
    super.initState();
  }

  void myValueSetter(int progress) {
    EasyLoading.showProgress((progress / 100), status: 'Đang tải ảnh lên: $progress%');
  }

  void setImageKey(String imageKey) {
    EasyLoading.dismiss();
    setState(() {
      image.text = imageKey;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Material(
            color: Colors.transparent,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        children: [
                          IconButton(
                              icon: const Icon(Icons.keyboard_backspace, color: Colors.white, size: 28,),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                             ),
                          const SizedBox(width: 16,),
                          const Text('Chỉnh sửa thông tin cá nhân', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Container(
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 16),
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.brown.shade800,
                                backgroundImage: NetworkImage(image.text),
                              ),
                              const SizedBox(height: 8,),
                              ElevatedButton(
                                onPressed: () async {
                                  var picked = await FilePicker.platform.pickFiles(
                                    withReadStream: true
                                  );

                                  if (picked != null) {
                                    UploadFileRequest.fetchUploadFile(widget.access_token, 'image', picked.files.first, myValueSetter, setImageKey).then((value) => {

                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  minimumSize: const Size(100, 36),
                                  maximumSize: const Size(200, 36),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  backgroundColor: const Color.fromARGB(255, 38, 38, 115),
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                child: Container(
                                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                                    child: const Text('Thay đổi avatar', style: TextStyle(color: Colors.white)),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Họ:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                              TextFormField(
                                controller: firstName,
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
                              const Text('Tên:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                              TextFormField(
                                controller: lastName,
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
                                controller: intro,
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
                              const Text('Số điện thoại: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                controller: phoneNumber,
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
                              const Text('Ngày sinh: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                              TextFormField(
                                controller: birthDate,
                                // The validator receives the text that the user has entered.
                                decoration: const InputDecoration(
                                    icon: Icon(Icons.calendar_today), //icon of text field
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Điền đầy đủ thông tin';
                                  }
                                  return null;
                                },
                                readOnly: true,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime(2100));

                                  if (pickedDate != null) {
                                    String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                                    setState(() {
                                      birthDate.text =
                                          formattedDate; //set output date to TextField value.
                                    });
                                  } else {}
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Giới tính: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                              DropdownButtonFormField(
                                value: gender,
                                isExpanded: true,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value;
                                  });
                                },
                                onSaved: (value) {
                                  setState(() {
                                    gender = value;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "can't empty";
                                  } else {
                                    return null;
                                  }
                                },
                                items: genderList
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
                          const SizedBox(height: 40),
                          ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Đang xử lý')),
                              );
                              EditUserRequest.fetchEditUser(widget.access_token, firstName.text, lastName.text, inputFormat.format(f.parse(birthDate.text.toString()))
                                  , gender!, intro.text, image.text, phoneNumber.text).then((value) => {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    title: const Text('Thông báo'),
                                    content: Container(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          Text('Cập nhật thông tin thành công'),
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
                                ),
                                widget.updateUser(firstName.text, lastName.text, inputFormat.format(f.parse(birthDate.text.toString())), gender!, intro.text, image.text, phoneNumber.text),
                              });
                            }
                          },
                          child: const Text('Cập nhật', style: TextStyle(color: Colors.white)),
                        ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
        )
    );
  }
}
