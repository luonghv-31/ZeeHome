import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:zeehome/model/user.dart';
import 'package:intl/intl.dart';
import 'package:zeehome/network/uploadFile_request.dart';
import 'package:zeehome/utils/constants.dart';

class EditUserDetail extends StatefulWidget {
  final User user;
  final String access_token;
  final Size size;
  final f = DateFormat('dd-MM-yyyy');
  final inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ssZ");
  EditUserDetail({Key? key, required this.user, required this.size, required this.access_token}) : super(key: key);

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
                              style: IconButton.styleFrom(
                                foregroundColor: Colors.red,
                                backgroundColor: Colors.red,
                                disabledBackgroundColor: Colors.red.withOpacity(0.12),
                                hoverColor: Colors.red.withOpacity(0.08),
                                focusColor: Colors.red.withOpacity(0.12),
                                highlightColor: Colors.red.withOpacity(0.12),
                              )),
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
                              SizedBox(height: 16),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.brown.shade800,
                                backgroundImage: NetworkImage(image.text),
                                child: Text('AH'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  var picked = await FilePicker.platform.pickFiles(
                                    withReadStream: true
                                  );

                                  if (picked != null) {
                                    print(picked.files.first.name);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  minimumSize: const Size(100, 36),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  backgroundColor: const Color.fromARGB(255, 38, 38, 115),
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                child: Text('Thay đổi avatar'),
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
                                keyboardType: TextInputType.number,
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
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Đang xử lý')),
                                );
                              }
                              // showDialog<String>(
                              //   context: context,
                              //   builder: (BuildContext context) => AlertDialog(
                              //     title: const Text('Thông báo'),
                              //     content: Container(
                              //       child: Column(
                              //         crossAxisAlignment: CrossAxisAlignment.stretch,
                              //         mainAxisSize: MainAxisSize.min,
                              //         children: const [
                              //           Text('Cập nhật thông tin thành công'),
                              //         ],
                              //       ),
                              //     ),
                              //     actions: <Widget>[
                              //       TextButton(
                              //         onPressed: () => Navigator.pop(context, 'Cancel'),
                              //         child: const Text('Xác nhận'),
                              //       ),
                              //     ],
                              //   ),
                              // );
                            },
                            child: const Text('Cập nhật'),
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
