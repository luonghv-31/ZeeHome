import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zeehome/model/authProvider.dart';
import 'package:zeehome/model/houseProvider.dart';
import 'package:zeehome/screens/createHouse/components/houseExtraInfo.dart';

class ExtraInfoScreen extends StatelessWidget {
  const ExtraInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, HouseProvider>(builder: (context, authProvider, houseProvider ,child){
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
                                        ),
                                        const SizedBox(width: 16,),
                                        const Text('Thêm thông tin', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
                                      ],
                                    ),
                                    const SizedBox(height: 32),
                                    HouseExtraInfo(access_token: authProvider.accessToken, setExtraHouseInfo: houseProvider.setExtraInfo, getHouseInfo: houseProvider.getHouseInfor),
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
