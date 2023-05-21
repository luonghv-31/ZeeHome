import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zeehome/model/houseProvider.dart';
import 'package:zeehome/screens/editHouse/components/houseBasicInfor.dart';

class EditHouseScreen extends StatefulWidget {
  const EditHouseScreen({Key? key}) : super(key: key);

  @override
  State<EditHouseScreen> createState() => _EditHouseScreenState();
}

class _EditHouseScreenState extends State<EditHouseScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HouseProvider>(builder: (context, houseProvider ,child){
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
                                        const Text('Cập nhật bài đăng', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
                                      ],
                                    ),
                                    const SizedBox(height: 32),
                                    HouseBasicInfor(houseProvider: houseProvider,),
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
