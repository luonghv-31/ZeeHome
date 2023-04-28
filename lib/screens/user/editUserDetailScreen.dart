import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zeehome/model/authProvider.dart';
import 'package:zeehome/model/userProvider.dart';
import 'package:zeehome/screens/user/components/editUserDetail.dart';

class EditUserDetailScreen extends StatefulWidget {
  const EditUserDetailScreen({Key? key}) : super(key: key);

  @override
  State<EditUserDetailScreen> createState() => _EditUserDetailScreenState();
}

class _EditUserDetailScreenState extends State<EditUserDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer2<UserProvider, AuthProvider>(builder: (context, userProvider, authProvider ,child){
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
                      EditUserDetail(user: userProvider.getUserObj(), size: size, access_token: authProvider.accessToken,)
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
