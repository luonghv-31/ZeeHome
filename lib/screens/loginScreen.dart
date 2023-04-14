// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, use_key_in_widget_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zeehome/model/auth.dart';
import 'package:zeehome/model/authProvider.dart';
import 'package:zeehome/model/userProvider.dart';
import 'package:zeehome/network/auth_request.dart';
import 'package:zeehome/network/user_request.dart';

import 'package:zeehome/screens/home/homeScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool isRememberMe = false;
  bool isShowHidePass = true;

  Auth auth = Auth(access_token: '', refresh_token: '');

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget buildEmail(){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        'Tên người dùng',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold
        ),
      ),
      SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0,2)
            )
          ]
        ),
        height: 60,
        // ignore: prefer_const_constructors
        child: TextField(
          controller: usernameController,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Colors.black87
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top:14),
            
            prefixIcon: Icon(
              Icons.account_circle_outlined,
              color: Color(0xff5ac18e),
            ),
            hintText: 'Nhập tên người dùng',
            hintStyle: TextStyle(
              color: Colors.black38
            )
          ),
        ),
      )
    ],
  );
}

  Widget buildPassword(){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        'Mật khẩu',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold
        ),
      ),
      SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0,2)
            )
          ]
        ),
        height: 60,
        // ignore: prefer_const_constructors
        child: TextField(
          controller: passwordController,
          obscureText: isShowHidePass,
          style: TextStyle(
            color: Colors.black87
          ),
          
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top:14),
            
            prefixIcon: Icon(
              Icons.lock,
              color: Color(0xff5ac18e),
            ),
            hintText: 'Nhập mật khẩu',
            hintStyle: TextStyle(
              color: Colors.black38
            ),
            suffixIcon: showHidePass(),
          ),
        ),
      )
    ],
  );
}

  Widget showHidePass(){
  return IconButton(
    onPressed: (){
      setState(() {
        isShowHidePass = !isShowHidePass;
      });
    }, 
    icon: isShowHidePass ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
    color: Colors.green,
    );
}

  Widget buidForgotPassBtn() {
  return Container(
    alignment: Alignment.centerRight,
    child: TextButton(
      style: TextButton.styleFrom(    
            
        padding: EdgeInsets.only(right: 0),        
      ),
      onPressed: ()=> print('quenmk'),
      
      child: Text(
        'Quên mật khẩu?',
        style: TextStyle(
          color: Color(0xffCFA1E6),
          fontWeight: FontWeight.bold
        ),
        ),
    ),
  );
}

  Widget buildRememberCb() {
    return Container(
    height: 20,
    child: Row(
      children: <Widget>[
        Theme(
          data: ThemeData(unselectedWidgetColor: Color(0xffCFA1E6)),
          child: Checkbox(
            value: isRememberMe,
            checkColor: Colors.black,
            activeColor: Color(0xffCFA1E6),
            onChanged: (bool ? value) {
              setState(() {
                isRememberMe = value!;
              });
            },
          ),
        ),
        Text(
          'Ghi nhớ tài khoản',
          style: TextStyle(
            color: Color(0xffCFA1E6),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
  }

  Route scaleIn(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, page) {
        var begin = 0.9;
        var end = 1.0;
        var curve = Curves.easeInOutBack;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        var tween2 = Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));


        return ScaleTransition(
          scale: animation.drive(tween),
          child: FadeTransition(
                  opacity: animation.drive(tween2),
                  child: page,
                ),
        );
      },
    );
  }

  Widget buildLoginBtn(){
    return Consumer2<AuthProvider, UserProvider>(builder: (context, authProvider, userProvider, child) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 5,
            padding: EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6)
            ),
            backgroundColor: Color.fromARGB(255, 0, 106, 255)
        ),

        onPressed: () {
          SignInRequest.fetchAuth(usernameController.text, passwordController.text).then((data) {
            setState(() {
              access_token: data.access_token;
              reresh_token: data.refresh_token;
            });

            authProvider.setAccessToken(data.access_token);

            GetUserRequest.fetchUser(data.access_token).then((data) => {
              userProvider.set(data.gender, data.phoneNumber, data.intro, data.image, data.birthDate, data.firstName, data.lastName, data.email, data.registerAt, data.banned, data.avgRating, data.title, data.role, data.userId, data.balance),
              Navigator.of(context).push(scaleIn(HomeScreen()))
          });
          });
        },
        child: Text('Đăng nhập', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),),
      ),
    );
  });
  }
  Widget buildAccout() {
  return GestureDetector(
    onTap: () => print('Ok'),
    child: RichText(
      text: TextSpan(
        children: [
          TextSpan(
          text: 'Chưa có tài khoản?',
          style: TextStyle(
          color: Color.fromARGB(255, 106, 23, 238),
          fontSize: 18,
          fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
            text: ' Đăng kí ngay.',
            style: TextStyle(
              color: Color.fromARGB(255, 106, 23, 238),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
        
      ),
      
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background2.jpg"),
                  fit: BoxFit.cover,
                ),
                  
              ),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 120
                ),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    // width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0,2)
                        )
                      ]
                    ),
                    child: Image.asset("assets/logo.png",
                      width: 60,
                      height: 60,
                    ),
                  ),
                  RichText(text: TextSpan(children: <TextSpan>[
                    TextSpan(text: 'Zee ', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 40, fontWeight: FontWeight.w900)),
                    TextSpan(text: 'Home', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 40, fontWeight: FontWeight.w500))
                  ])),
                  SizedBox(height: 50,),
                  buildEmail(),
                  SizedBox(height: 20,),
                  buildPassword(),
                  buidForgotPassBtn(),
                  
                  buildRememberCb(),
                  buildLoginBtn(),
                  buildAccout()
                ],
              ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
