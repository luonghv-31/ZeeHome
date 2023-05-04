import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zeehome/model/authProvider.dart';
import 'package:zeehome/model/houseProvider.dart';
import 'package:zeehome/model/userProvider.dart';
import 'package:zeehome/screens/createHouse/components/houseBasicInfor.dart';

class CreateHouseScreen extends StatefulWidget {
  const CreateHouseScreen({Key? key}) : super(key: key);

  @override
  State<CreateHouseScreen> createState() => _CreateHouseScreenState();
}

class _CreateHouseScreenState extends State<CreateHouseScreen> {

  @override
  Widget build(BuildContext context) {
    return Consumer3<AuthProvider, HouseProvider, UserProvider>(builder: (context, authProvider, houseProvider, userProvider ,child){
      return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            child: Stack(children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/background_app.png"),
                    fit: BoxFit.cover,
                  ),

                ),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Material(
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
                                              disabledBackgroundColor: Colors.red.withOpacity(0.12),
                                              hoverColor: Colors.red.withOpacity(0.08),
                                              focusColor: Colors.red.withOpacity(0.12),
                                              highlightColor: Colors.red.withOpacity(0.12),
                                            )),
                                        const SizedBox(width: 16,),
                                        const Text('Tạo bài đăng', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
                                      ],
                                    ),
                                    const SizedBox(height: 32),
                                    HouseBasicInfor(access_token: authProvider.accessToken, updateBasicInfo: houseProvider.setBasicInfo, userInfo: userProvider.getUserObj()),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 32),
                            ],
                          )
                      )
                    ],
                  ),
                ),
              )
            ]),
          ),
        ),
      );
    });
  }
}
