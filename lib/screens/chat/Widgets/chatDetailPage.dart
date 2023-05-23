import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeehome/model/chat/ChatMessages.dart';
import 'package:zeehome/model/chat/chatModel.dart';
import 'package:zeehome/model/chat/chatUser.dart';
import 'package:zeehome/model/user.dart';
import 'package:zeehome/model/userProvider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';

import '../../../network/uploadFile_request1.dart';

class ChatDetailPage extends StatefulWidget {
  ChatUser chatUser;

  ChatDetailPage({super.key, required this.chatUser});

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

ScrollController _scrollController = new ScrollController();
void _scrollBottom() {
  _scrollController.animateTo(_scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 1), curve: Curves.easeOut);
  print('okk');
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  Future<void> _initStateAsync() async {
    await Future.delayed(Duration.zero);

    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 10),
      );
    }
    print('Init complete!');
  }

  @override
  void initState() {
    // TODO: implement initState

    Provider.of<ChatModel>(context, listen: false)
        .getChatHistory(widget.chatUser.userId);
    _initStateAsync();
    super.initState();
//  WidgetsBinding.instance!.addPostFrameCallback((_) {
//       _scrollBottom();
//     });
  }

  TextEditingController chatTextController = TextEditingController();

  String parseMessageBody(String body) {
    final result = json.decode(body);
    if (result['image'] != null) {
      return result['image'].toString();
    } else {
      return result['text'].toString();
    }
  }

  bool check_img(String imgURL) {
    final matcher = new RegExp(
        r"(http(s)?:\/\/.)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)");
    return matcher.hasMatch(imgURL);
  }

  @override
  void dispose() {
    chatTextController.dispose();
    super.dispose();
  }

  void handleSubmitChat(User myInfo) {
    if (imgURL != null) {
      print(chatTextController);
      print(imgURL);
      Provider.of<ChatModel>(context, listen: false).sendImageMessage(
          chatTextController.text,
          imgURL!,
          From(
              sId: myInfo.userId,
              firstName: myInfo.firstName,
              lastName: myInfo.lastName),
          From(
              sId: widget.chatUser.userId,
              firstName: widget.chatUser.firstName,
              lastName: widget.chatUser.lastName));
      chatTextController.text = '';
      imgURL = null;
    } else {
      Provider.of<ChatModel>(context, listen: false).sendTextMessage(
          chatTextController.text,
          From(
              sId: myInfo.userId,
              firstName: myInfo.firstName,
              lastName: myInfo.lastName),
          From(
              sId: widget.chatUser.userId,
              firstName: widget.chatUser.firstName,
              lastName: widget.chatUser.lastName));
      chatTextController.text = '';
    }
  }

  String? token;
  dynamic image;
  String pathIMG = '';

  final ImagePicker _picker = ImagePicker();

  void myValueSetter(int progress) {
    EasyLoading.showProgress((progress / 100),
        status: 'Đang tải ảnh lên: $progress%');
  }

  String? imgURL;
  void setThumbnail(String imageKey) {
    EasyLoading.dismiss();
    setState(() {
      imgURL = imageKey;
    });
  }

  bool checkImage() {
    if (image != null) {
      return true;
    }
    return false;
  }

  bool showIMG = false;

  @override
  Widget build(BuildContext context) {
    return Consumer2<ChatModel, UserProvider>(
        builder: (context, chatModel, userProvider, child) {
      // if (chatModel.hasListeners) {
      //   WidgetsBinding.instance.addPostFrameCallback((_) {
      //     _scrollController.animateTo(
      //       _scrollController.position.maxScrollExtent,
      //       duration: Duration(milliseconds: 300),
      //       curve: Curves.easeOut,
      //     );
      //   });
      // }
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage('${widget.chatUser?.image}'),
                    maxRadius: 20,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '${widget.chatUser?.firstName} ${widget.chatUser?.lastName}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.info,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 70),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
                child: ListView.builder(
                  itemCount: chatModel.messages.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.only(
                          left: 14, right: 14, top: 10, bottom: 10),
                      child: Align(
                        alignment: (chatModel.messages[index].to?.sId ==
                                userProvider.userId
                            ? Alignment.centerLeft
                            : Alignment.centerRight),
                        child: Container(
                          margin: (chatModel.messages[index].to?.sId ==
                                  userProvider.userId
                              ? EdgeInsets.only(right: 110)
                              : EdgeInsets.only(left: 110)),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: check_img(parseMessageBody(
                                    chatModel.messages[index].body!))
                                ? Colors.white
                                : (chatModel.messages[index].to?.sId ==
                                        userProvider.userId
                                    ? Colors.grey.shade200
                                    : const Color.fromARGB(255, 144, 249, 242)),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: check_img(parseMessageBody(
                                  chatModel.messages[index].body!))
                              ? GestureDetector(
                                  child: Image.network(
                                    parseMessageBody(
                                        chatModel.messages[index].body!),
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                    width: 150,
                                    height: 150,
                                  ),
                                  onTap: () {
                                    image = Image.network(parseMessageBody(
                                            chatModel.messages[index].body!))
                                        .image;
                                    showImageViewer(context, image);
                                  },
                                )
                              : Text(
                                  parseMessageBody(
                                      chatModel.messages[index].body!),
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, bottom: 30, top: 0),
                height: 80,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {
                        final XFile? image = await _picker.pickImage(
                            source: ImageSource.gallery);
                        if (image != null) {
                          SharedPreferences.getInstance().then((prefs) {
                            String access_token =
                                prefs.get('access_token') as String;
                            print(access_token);
                            UploadFileRequest.fetchUploadFile(access_token,
                                'image', image, myValueSetter, setThumbnail);
                          });
                          setState(() {
                            showIMG = true;
                            pathIMG = image.path;
                          });
                        } else {
                          print('chưa chọn ảnh');
                          setState(() {
                            showIMG = false;
                            pathIMG = '';
                          });
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(
                          Icons.image,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextField(
                        controller: chatTextController,
                        minLines: 1,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: "Nhập tin nhắn...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none,
                          suffixIcon: showIMG
                              ? Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Image.file(
                                    File(pathIMG),
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.fill,
                                  ))
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          showIMG = false;
                        });

                        handleSubmitChat(userProvider.getUserObj());
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (_scrollController.hasClients) {
                            _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent,
                              curve: Curves.easeOut,
                              duration: const Duration(milliseconds: 1),
                            );
                          }
                        });
                      },
                      backgroundColor: Colors.blue,
                      elevation: 1,
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
