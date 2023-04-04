// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, use_key_in_widget_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}



class _LoginScreenState extends State<LoginScreen> {

bool isRememberMe = false;
bool isShowHidePass = true;

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

Widget buildLoginBtn(){
  
  return Container(
    padding: EdgeInsets.symmetric(vertical: 25),
    width: double.infinity,
    child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      elevation: 5,
      padding: EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      backgroundColor: Color(0xFF242AE1)
    ),
      
    onPressed: () { },
    child: Text('Đăng nhập'),
    ),
  );
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
                  image: AssetImage("assets/images/login.jpeg"),
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
                  
                  Image.asset("assets/logo.png",
                  width: 70,
                  height: 70,),
                  Text(
                    'Zee Home',
                    style: TextStyle(
                      color: Color(0xff5463E8),
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
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
